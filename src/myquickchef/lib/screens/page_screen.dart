import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myquickchef/screens/favorite_screen.dart';

import 'home_screen.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  int _currentIndex = 0;

  Future<CameraDescription> getCamera() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

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
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded), label: "Preferiti")
        ],
      ),
      body: _currentIndex == 0
          ? FutureBuilder(
              future: getCamera(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Image.asset("lib/icons/loading_mqc.gif"));
                } else if (snapshot.hasData) {
                  return HomeScreen(camera: snapshot.data!);
                } else {
                  return const Center(
                      child: Text(
                    "Camera error.\nPlease restart the app.",
                    textAlign: TextAlign.center,
                  ));
                }
              },
            )
          : FavoriteScreen(),
    );
  }
}
