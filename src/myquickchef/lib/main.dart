import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'screens/page_screen.dart';
import 'styles/style_guide.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    MaterialApp(
      title: "MyQuickChef",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: buildColorSchemeTheme(),
        textTheme: buildTextTheme(),
      ),
      home: SafeArea(
        child: PageScreen(
          camera: firstCamera,
        ),
      ),
    ),
  );
}
