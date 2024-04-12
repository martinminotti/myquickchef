import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquickchef/screens/favorite_screen.dart';

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
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 30,
          iconSize: 30,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star_rounded), label: "Preferiti")
          ],
        ),
      ),
      body: _currentIndex == 0
          ? HomeScreen(
              camera: widget.camera,
            )
          : FavoriteScreen(),
    );
  }
}
