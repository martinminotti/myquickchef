import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myquickchef/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/page_screen.dart';
import 'styles/style_guide.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final onBoarding = prefs.getBool("onboarding") ?? true;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: buildColorSchemeTheme().onPrimary,
      systemNavigationBarIconBrightness: Brightness.dark));

  runApp(
    MaterialApp(
        title: "MyQuickChef",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: buildColorSchemeTheme(),
          textTheme: buildTextTheme(),
        ),
        home: onBoarding
            ? OnBoardingScreen(
                prefs: prefs,
              )
            : const PageScreen()),
  );
}
