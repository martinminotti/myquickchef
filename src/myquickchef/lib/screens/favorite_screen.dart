import 'package:flutter/material.dart';
import 'package:myquickchef/screens/results_screen.dart';
import 'package:myquickchef/services/file_recipes.dart';
import 'package:myquickchef/widgets/recipe_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return RecipeCard(snapshot.data![index]);
            },
          );
        } else {
          return const Center(
              child: Text(
            "No favorites",
            textAlign: TextAlign.center,
          ));
        }
      },
    );
  }
}
