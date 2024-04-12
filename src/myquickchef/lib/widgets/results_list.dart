import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myquickchef/services/analyze_image.dart';
import 'package:myquickchef/widgets/recipe_card.dart';

class ResultsList extends StatelessWidget {
  final XFile image;

  const ResultsList({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: analyzeImage(image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: snapshot.data![index]);
            },
          );
        } else {
          return const Center(
              child: Text(
            "Food not recognized.\nPlease pick another image.",
            textAlign: TextAlign.center,
          ));
        }
      },
    );
  }
}
