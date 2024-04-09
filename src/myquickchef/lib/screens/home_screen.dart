import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  late XFile _image;
  var torch = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("MyQuickChef")],
          ),
        ),
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
                              ? await _controller.setFlashMode(FlashMode.torch)
                              : await _controller.setFlashMode(FlashMode.off);

                          print(torch);

                          if (!context.mounted) return;
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: torch
                          ? const Icon(Icons.flash_on)
                          : const Icon(Icons.flash_off))
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(55, 55), shape: const CircleBorder()),
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;
                          _image = await _controller.takePicture();

                          if (!context.mounted) return;

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DisplayPictureScreen(
                                imagePath: _image.path,
                              ),
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Icon(Icons.camera_alt))
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await getImage();
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              imagePath: _image.path,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.image))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
