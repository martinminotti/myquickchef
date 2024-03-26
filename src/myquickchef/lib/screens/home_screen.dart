import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("MyQuickChef")],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 500,
                  width: 300,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: null, child: Icon(Icons.flash_off))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape:
                                MaterialStatePropertyAll(CircleBorder())),
                        onPressed: null,
                        child: Icon(Icons.camera_alt))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: null, child: Icon(Icons.image))
                  ],
                ),
              ],
            ),
          )
        ],
      );
  }
}
