import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  /// controlador da camera
  late CameraController _controller;

  /// lista de cameras disponíveis
  late List<CameraDescription> cameras;

  /// camera frontal
  late CameraDescription frontCamera;

  /// flag de inicialização da camera
  bool isCameraInitialized = false;

  /// flag de inicialização flash
  bool _isFlashOn = false;

  /// picker de imagem
  final ImagePicker _picker = ImagePicker();

  /// imagem capturada
  File? _image;

  /// erro customizado
  CustomError error = resolve<CustomError>();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCameraInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
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
                        child: Icon(Icons.camera),
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

  /// Inicializa a camera
  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    // Tenta encontrar a câmera frontal
    try {
      frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
    } catch (e) {
      // Se não encontrar, use a primeira câmera disponível ou trate o erro
      if (cameras.isNotEmpty) {
        frontCamera = cameras.first;
      } else {
        error.sendErrorToCrashlytics(
            code: ErrorCodes.cameraError, stackTrace: StackTrace.current);

        Navigator.of(context).pop(error);
        return;
      }
    }

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
    );

    try {
      await _controller.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.cameraError, stackTrace: StackTrace.current);
      Navigator.of(context).pop(error);
      return;
    }
  }

  /// Captura uma imagem
  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    final XFile? picture = await _controller.takePicture();
    if (picture != null) {
      _showPreviewDialog(File(picture.path));
    }
  }

  /// Seleciona uma imagem da galeria
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        Navigator.of(context).pop(_image);
      }
    });
  }

  /// Alterna o flash
  Future<void> _toggleFlash() async {
    if (_isFlashOn) {
      await _controller.setFlashMode(FlashMode.off);
    } else {
      await _controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  void _showPreviewDialog(File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pré-visualizar Imagem'),
          content: Image.file(imageFile),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Rejeitar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                setState(() {
                  _image = imageFile;
                });

                Navigator.of(context)
                    .pop(imageFile); // Retorna a imagem aprovada
              },
              child: const Text('Aprovar'),
            ),
          ],
        );
      },
    );
  }
}
