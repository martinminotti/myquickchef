import 'package:flutter/material.dart';

import 'screens/page_screen.dart';
import 'styles/style_guide.dart';

void main() {
  runApp(
    MaterialApp(
      title: "MyQuickChef",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: buildColorSchemeTheme(),
        textTheme: buildTextTheme(),
      ),
      home: SafeArea(
        child: PageScreen(),
      ),
    ),
  );
}
