import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myquickchef/services/api_service.dart';

class AnalyzeImage extends StatelessWidget {
  final XFile image;

  const AnalyzeImage({super.key, required this.image});

  Future<dynamic> sendImage() async {
    // final res = await ApiService().sendImageToGPT4Vision(image: image);
    const res = "Olive oil, basil, parmesan cheese, garlic, pine nuts";
    if (res == "I don\"t know." || res == "Please pick another image.") {
      return [];
    }
    final recipeList =
        jsonDecode(await ApiService().sendIngredientsToGPT3(ingredients: res));
    return recipeList["recipes"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risultati'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: sendImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(snapshot.data![index]["name"]),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Ingredients:"),
                            Text(snapshot.data![index]["ingredients"]
                                .toString()),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text("Instructions:"),
                        Text(snapshot.data![index]["instructions"]),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}

// Card(
//                 elevation: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(snapshot.data!),
//                 ),
//               )