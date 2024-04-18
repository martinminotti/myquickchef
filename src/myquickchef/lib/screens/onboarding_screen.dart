import 'package:flutter/material.dart';
import 'package:myquickchef/main.dart';
import 'package:myquickchef/screens/page_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatelessWidget {
  final SharedPreferences prefs;

  const OnBoardingScreen({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(
                  "lib/icons/icon-myquickchef_1.png",
                  width: 150,
                  height: 150,
                )),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Inizia a Cucinare!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 27, 37, 54),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 25.0,
              ),
              child: Text(
                'Fotografa un alimento qualsiasi ed ottieni gustose ricette!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 70.0),
            ElevatedButton(
              onPressed: () async {
                await prefs.setBool("onboarding", false);
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PageScreen()));
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color.fromARGB(
                  255,
                  1,
                  186,
                  239,
                )),
                fixedSize: MaterialStatePropertyAll(Size(300, 60)),
              ),
              child: const Text(
                'Scopri Ora',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
