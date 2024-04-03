import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myquickchef/services/api_service.dart';

import '../widgets/analyze_image.dart';
import '../widgets/camera_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late XFile? _image;
  var torch = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.low,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<XFile?> getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MyQuickChef"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CameraBox(
                    initializeControllerFuture: _initializeControllerFuture,
                    controller: _controller),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            setState(() {
                              torch = !torch;
                            });
                            torch
                                ? await _controller
                                    .setFlashMode(FlashMode.torch)
                                : await _controller.setFlashMode(FlashMode.off);

                            if (!context.mounted) return;
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: torch
                            ? const Icon(Icons.flash_on_rounded)
                            : const Icon(Icons.flash_off_rounded))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(55, 55),
                            shape: const CircleBorder()),
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            _image = await _controller.takePicture();

                            if (!context.mounted) return;

                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AnalyzeImage(
                                  image: _image!,
                                ),
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Icon(Icons.camera_alt_rounded))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          _image = await getImage();

                          if (!context.mounted) return;

                          if (_image != null) {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AnalyzeImage(
                                  image: _image!,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.image_rounded))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
