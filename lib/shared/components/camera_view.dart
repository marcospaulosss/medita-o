import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
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
    frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.max,
    );

    await _controller.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  /// Captura uma imagem
  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    final XFile? picture = await _controller.takePicture();
    setState(() {
      if (picture != null) {
        _image = File(picture.path);

        Navigator.of(context).pop(_image);
      }
    });
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
}
