import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Um widget que fornece uma interface para captura de imagens usando a câmera do dispositivo
/// ou seleção de imagens da galeria.
///
/// Este componente oferece as seguintes funcionalidades:
/// - Captura de fotos usando a câmera frontal ou traseira
/// - Seleção de imagens da galeria
/// - Compressão automática de imagens
/// - Alternância entre câmera frontal e traseira
/// - Controle de flash
/// - Pré-visualização de imagens antes de confirmar
///
/// O componente retorna um [File] contendo a imagem selecionada/capturada.
@RoutePage()
class CameraView extends StatefulWidget {
  /// Controlador da câmera para testes
  final CameraController? testController;

  const CameraView({super.key, this.testController});

  @override
  State<CameraView> createState() => _CameraViewState();
}

/// Estado do widget [CameraView].
///
/// Gerencia o ciclo de vida da câmera, captura de imagens e interações do usuário.
class _CameraViewState extends State<CameraView> {
  /// Controlador da câmera que gerencia a captura de imagens
  CameraController? _controller;

  /// Lista de câmeras disponíveis no dispositivo
  late List<CameraDescription> cameras;

  /// Câmera atualmente em uso (frontal ou traseira)
  late CameraDescription currentCamera;

  /// Indica se a câmera foi inicializada com sucesso
  bool isCameraInitialized = false;

  /// Indica se o flash está ativado
  bool _isFlashOn = false;

  /// Instância do ImagePicker para seleção de imagens da galeria
  final ImagePicker _picker = ImagePicker();

  /// Imagem capturada ou selecionada da galeria
  File? _image;

  /// Instância para tratamento de erros customizados
  CustomError error = resolve<CustomError>();

  /// Lista de arquivos temporários criados durante a compressão de imagens
  final List<String> _tempFiles = [];

  @override
  void initState() {
    super.initState();
    if (widget.testController != null) {
      _controller = widget.testController;
      isCameraInitialized = true;
    } else {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _cleanupResources();
    }
    super.dispose();
  }

  /// Limpa recursos temporários e libera a câmera.
  ///
  /// Este método é chamado durante o dispose do widget e:
  /// - Libera o controlador da câmera (se existir)
  /// - Remove arquivos temporários criados durante a compressão
  /// - Registra erros de limpeza no Crashlytics
  ///
  /// O método verifica a existência do controlador antes de tentar liberá-lo,
  /// evitando erros de null safety.
  void _cleanupResources() {
    if (_controller != null) {
      _controller!.dispose();
    }
    for (var filePath in _tempFiles) {
      try {
        final file = File(filePath);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        debugPrint('Erro ao deletar arquivo temporário: $e');
        error.sendErrorToCrashlytics(
          message: 'Erro ao deletar arquivo temporário: $e',
          code: ErrorCodes.cameraError,
          stackTrace: StackTrace.current,
        );
      }
    }
  }

  /// Navega de volta para a tela anterior, opcionalmente retornando um resultado.
  ///
  /// [result] - O resultado a ser retornado para a tela anterior (opcional)
  void _navigateBack([dynamic result]) {
    Navigator.of(context).pop(result);
  }

  /// Exibe um diálogo de erro para o usuário.
  ///
  /// [message] - A mensagem de erro a ser exibida
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Inicializa a câmera do dispositivo.
  ///
  /// Este método:
  /// - Verifica se há câmeras disponíveis no dispositivo
  /// - Configura a câmera frontal como padrão (ou a primeira disponível)
  /// - Inicializa o controlador da câmera com configurações otimizadas:
  ///   - Resolução média para melhor qualidade
  ///   - Áudio desabilitado para melhor performance
  /// - Define um timeout de 10 segundos para evitar travamentos
  /// - Trata erros de inicialização e permissões
  ///
  /// Em caso de erro:
  /// - Registra o erro no Crashlytics
  /// - Exibe uma mensagem amigável ao usuário
  /// - Navega de volta para a tela anterior
  Future<void> _initializeCamera() async {
    try {
      // Verifica se há câmeras disponíveis
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('Nenhuma câmera disponível no dispositivo');
      }

      // Tenta encontrar a câmera frontal primeiro
      currentCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      // Inicializa o controlador com configurações otimizadas
      _controller = CameraController(
        currentCamera,
        ResolutionPreset.veryHigh, // Mudado para medium para melhor qualidade
        enableAudio: false, // Desabilita áudio pois não é necessário
      );

      // Inicializa a câmera com timeout
      await _controller!.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Timeout ao inicializar a câmera');
        },
      );

      if (!mounted) return;

      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Erro ao inicializar câmera: $e');
      error.sendErrorToCrashlytics(
        message: 'Erro ao acessar a câmera: $e',
        code: ErrorCodes.cameraError,
        stackTrace: StackTrace.current,
      );

      if (!mounted) return;

      _showErrorDialog(
          'Erro ao acessar a câmera. Por favor, verifique as permissões e tente novamente.');
      _navigateBack(error);
    }
  }

  /// Alterna entre a câmera frontal e traseira.
  ///
  /// Este método:
  /// - Identifica a câmera oposta à atual
  /// - Libera o controlador atual
  /// - Inicializa um novo controlador com a câmera selecionada
  /// - Atualiza o estado com a nova câmera
  Future<void> _switchCamera() async {
    try {
      final newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection != currentCamera.lensDirection,
        orElse: () => currentCamera,
      );

      await _controller!.dispose();
      _controller = CameraController(
        newCamera,
        ResolutionPreset.low,
      );

      await _controller!.initialize();
      setState(() {
        currentCamera = newCamera;
      });
    } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.cameraError, stackTrace: StackTrace.current);
      _showErrorDialog('Erro ao trocar de câmera');
    }
  }

  /// Captura uma imagem usando a câmera atual.
  ///
  /// Este método:
  /// - Verifica se a câmera está inicializada
  /// - Captura a imagem
  /// - Comprime a imagem capturada
  /// - Exibe diálogo de pré-visualização
  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) {
      _showErrorDialog('Câmera não inicializada');
      error.sendErrorToCrashlytics(
        message: 'Câmera não inicializada',
        code: ErrorCodes.cameraError,
        stackTrace: StackTrace.current,
      );
      return;
    }

    try {
      final XFile picture = await _controller!.takePicture();
      final compressedImage = await _compressImage(File(picture.path));
      setState(() {
        _image = compressedImage;
      });
      _showPreviewDialog(compressedImage);
        } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.cameraError, stackTrace: StackTrace.current);
      _showErrorDialog('Erro ao capturar imagem');
    }
  }

  /// Seleciona uma imagem da galeria do dispositivo.
  ///
  /// Este método:
  /// - Abre o seletor de imagens da galeria
  /// - Valida o formato do arquivo (jpg, jpeg, png)
  /// - Valida o tamanho do arquivo (máximo 30MB)
  /// - Comprime a imagem selecionada
  /// - Retorna a imagem comprimida
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Validação do tipo de arquivo
        if (!pickedFile.path.toLowerCase().endsWith('.jpg') &&
            !pickedFile.path.toLowerCase().endsWith('.jpeg') &&
            !pickedFile.path.toLowerCase().endsWith('.png')) {
          _showErrorDialog('Formato de arquivo não suportado');
          return;
        }

        // Validação do tamanho do arquivo (máximo 30MB)
        final file = File(pickedFile.path);
        if (await file.length() > 30 * 1024 * 1024) {
          _showErrorDialog('Arquivo muito grande. Máximo permitido: 30MB');
          return;
        }

        final compressedImage = await _compressImage(file);
        setState(() {
          _image = compressedImage;
        });
        _navigateBack(compressedImage);
      }
    } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.cameraError, stackTrace: StackTrace.current);
      _showErrorDialog('Erro ao selecionar imagem');
    }
  }

  /// Comprime uma imagem mantendo boa qualidade.
  ///
  /// [file] - O arquivo de imagem a ser comprimido
  ///
  /// Retorna um [File] contendo a imagem comprimida.
  ///
  /// Configurações de compressão:
  /// - Qualidade: 100%
  /// - Dimensões mínimas: 354x472 pixels
  /// - Formato: JPG
  /// - Remove metadados EXIF
  Future<File> _compressImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath =
          "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      _tempFiles.add(targetPath);

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 100,
        minWidth: 354,
        minHeight: 472,
        rotate: 0,
        keepExif: false,
      );

      if (result == null) {
        throw Exception('Falha na compressão da imagem');
      }

      return File(result.path);
    } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.cameraError, stackTrace: StackTrace.current);
      throw Exception('Erro ao comprimir imagem: $e');
    }
  }

  /// Alterna o estado do flash da câmera.
  ///
  /// Este método alterna entre flash ligado e desligado,
  /// atualizando o estado visual do botão.
  Future<void> _toggleFlash() async {
    try {
      if (_isFlashOn) {
        await _controller!.setFlashMode(FlashMode.off);
      } else {
        await _controller!.setFlashMode(FlashMode.torch);
      }
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.cameraError, stackTrace: StackTrace.current);
      _showErrorDialog('Erro ao alternar flash');
    }
  }

  /// Exibe um diálogo de pré-visualização da imagem.
  ///
  /// [imageFile] - O arquivo de imagem a ser pré-visualizado
  ///
  /// Permite ao usuário aprovar ou rejeitar a imagem capturada.
  void _showPreviewDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pré-visualizar Imagem'),
          content: Image.file(imageFile, fit: BoxFit.cover),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Rejeitar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateBack(imageFile);
              },
              child: const Text('Aprovar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: isCameraInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  top: 110,
                  bottom: 200,
                  left: 30,
                  right: 30,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: CameraPreview(_controller!),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => _navigateBack(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        heroTag: 'flash',
                        onPressed: _toggleFlash,
                        child: Icon(
                          _isFlashOn ? Icons.flash_on : Icons.flash_off,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: 'camera',
                        onPressed: _takePicture,
                        child: const Icon(Icons.camera),
                      ),
                      FloatingActionButton(
                        heroTag: 'switch_camera',
                        onPressed: _switchCamera,
                        child: const Icon(Icons.flip_camera_ios),
                      ),
                      FloatingActionButton(
                        heroTag: 'library',
                        onPressed: _pickImageFromGallery,
                        child: const Icon(Icons.photo_library),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
