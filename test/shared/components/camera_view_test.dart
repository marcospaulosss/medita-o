/// Testes para o componente CameraView
/// Este arquivo contém testes de widget para verificar o comportamento do componente CameraView,
/// que é responsável por gerenciar a câmera e a captura de imagens no aplicativo.

import 'package:camera/camera.dart';
import 'package:cinco_minutos_meditacao/shared/components/camera_view.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

/// Gera classes mock para os seguintes componentes:
/// - CameraController: Controlador da câmera
/// - ImagePicker: Seletor de imagens da galeria
/// - CustomError: Gerenciador de erros customizado
/// - XFile: Representação de arquivo de imagem
@GenerateMocks([
  CameraController,
  ImagePicker,
  CustomError,
  XFile,
])
import 'camera_view_test.mocks.dart';

void main() {
  /// Variáveis utilizadas em todos os testes
  late MockCameraController mockCameraController;
  late MockImagePicker mockImagePicker;
  late MockCustomError mockError;
  late GetIt getIt;
  late MockXFile mockXFile;

  /// Configuração inicial executada antes de cada teste
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockCameraController = MockCameraController();
    mockImagePicker = MockImagePicker();
    mockError = MockCustomError();
    mockXFile = MockXFile();
    getIt = GetIt.instance;

    // Limpa registros anteriores do GetIt para evitar conflitos
    if (getIt.isRegistered<CustomError>()) {
      getIt.unregister<CustomError>();
    }
    if (getIt.isRegistered<ImagePicker>()) {
      getIt.unregister<ImagePicker>();
    }

    // Registra as dependências mockadas no GetIt
    getIt.registerSingleton<CustomError>(mockError);
    getIt.registerSingleton<ImagePicker>(mockImagePicker);

    // Configura o comportamento do mock de erro
    when(mockError.sendErrorToCrashlytics(
      message: anyNamed('message'),
      code: anyNamed('code'),
      stackTrace: anyNamed('stackTrace'),
      dioException: anyNamed('dioException'),
    )).thenReturn(mockError);

    // Configura o comportamento do mock do controlador da câmera
    when(mockCameraController.initialize()).thenAnswer((_) async => null);
    when(mockCameraController.value).thenReturn(
      CameraValue(
        isInitialized: true,
        previewSize: const Size(100, 100),
        deviceOrientation: DeviceOrientation.portraitUp,
        exposureMode: ExposureMode.auto,
        focusMode: FocusMode.auto,
        isRecordingVideo: false,
        isRecordingPaused: false,
        isStreamingImages: false,
        isTakingPicture: false,
        flashMode: FlashMode.off,
        exposurePointSupported: true,
        focusPointSupported: true,
        description: const CameraDescription(
          name: 'Test Camera',
          lensDirection: CameraLensDirection.front,
          sensorOrientation: 0,
        ),
      ),
    );
    when(mockCameraController.dispose()).thenAnswer((_) async => null);
    when(mockCameraController.setFlashMode(any)).thenAnswer((_) async => null);
    when(mockCameraController.takePicture()).thenAnswer((_) async => mockXFile);
    when(mockCameraController.buildPreview()).thenReturn(
      Container(
        width: 100,
        height: 100,
        color: Colors.black,
      ),
    );

    // Configura o comportamento do mock do arquivo de imagem
    when(mockXFile.path).thenReturn('test.jpg');
    when(mockXFile.length()).thenAnswer((_) async => 1024); // 1KB
  });

  /// Limpeza executada após cada teste
  tearDown(() {
    // Remove os registros do GetIt para evitar interferência entre testes
    if (getIt.isRegistered<CustomError>()) {
      getIt.unregister<CustomError>();
    }
    if (getIt.isRegistered<ImagePicker>()) {
      getIt.unregister<ImagePicker>();
    }
  });

  /// Teste que verifica se o componente CameraView é inicializado corretamente
  /// Espera encontrar uma instância do widget CameraView na árvore de widgets
  testWidgets('CameraView deve inicializar corretamente',
      (WidgetTester tester) async {
    // Cria um widget wrapper que injeta o CameraController mockado
    final widget = MaterialApp(
      home: Scaffold(
        body: CameraView(testController: mockCameraController),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(CameraView), findsOneWidget);
  });

  /// Teste que verifica se o preview da câmera é exibido após a inicialização
  /// Espera encontrar uma instância do widget CameraPreview na árvore de widgets
  testWidgets('CameraView deve mostrar preview da câmera após inicialização',
      (WidgetTester tester) async {
    // Cria um widget wrapper que injeta o CameraController mockado
    final widget = MaterialApp(
      home: Scaffold(
        body: CameraView(testController: mockCameraController),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(CameraPreview), findsOneWidget);
  });

  /// Teste que verifica se o flash da câmera é alternado corretamente
  /// 1. Toca no botão de flash
  /// 2. Verifica se o método setFlashMode foi chamado com o modo torch
  testWidgets('CameraView deve alternar flash corretamente',
      (WidgetTester tester) async {
    // Cria um widget wrapper que injeta o CameraController mockado
    final widget = MaterialApp(
      home: Scaffold(
        body: CameraView(testController: mockCameraController),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump(const Duration(seconds: 1));

    // Encontra e toca no botão de flash
    final flashButton = find.byIcon(Icons.flash_off);
    expect(flashButton, findsOneWidget);
    
    await tester.tap(flashButton);
    await tester.pump();

    verify(mockCameraController.setFlashMode(FlashMode.torch)).called(1);
  });
}
