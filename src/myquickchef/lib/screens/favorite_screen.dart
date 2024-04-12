import 'package:flutter/material.dart';

import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/widgets/favorite_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: FavoriteList(),
    );
  }
}
