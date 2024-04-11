// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/services/file_recipes.dart';
import 'package:myquickchef/widgets/favorite_card.dart';
import 'package:myquickchef/widgets/recipe_card.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Recipe> favoritesList = [];
  @override
  void initState() {
    super.initState();
    loadList().then((updatedList) {
      setState(() {
        favoritesList = updatedList;
      });
    });
  }

  void onDelete(int index) {
    setState(() {
      favoritesList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return favoritesList.isEmpty
        ? const Center(
            child: Text(
            "No favorites",
            textAlign: TextAlign.center,
          ))
        : GridView.builder(
            itemCount: favoritesList.length,
            itemBuilder: (context, index) {
              return FavoriteCard(
                recipe: favoritesList[index],
                onDelete: () => onDelete(index),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 5,
              mainAxisExtent: 290,
            ),
          );
  }
}




// @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: loadList(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasData) {
//           if (snapshot.data!.isEmpty) {
//             return const Center(
//                 child: Text(
//               "No favorites",
//               textAlign: TextAlign.center,
//             ));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return RecipeCard(snapshot.data![index]);
//             },
//           );
//         } else {
//           return const Center(
//               child: Text(
//             "Error loading JSON file",
//             textAlign: TextAlign.center,
//           ));
//         }
//       },
//     );
