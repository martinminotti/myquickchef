import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_screen.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        // selectedItemColor: Theme.of(context).primaryColor,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Preferiti")
        ],
      ),
      body: _currentIndex == 0
          ? HomeScreen(
              camera: widget.camera,
            )
          : Scaffold(),
    );
  }
}
