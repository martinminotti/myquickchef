import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';

class RecipeCardScreen extends StatefulWidget {
  const RecipeCardScreen({required this.recipe, super.key});

  final Recipe recipe;

  @override
  State<RecipeCardScreen> createState() => _RecipeCardScreenState();
}

class _RecipeCardScreenState extends State<RecipeCardScreen> {
  var click = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () async {
            await Navigator.maybePop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.recipe.name),
              ],
            ),
            Row(
              children: [
                Text(
                    "${widget.recipe.category} • ${widget.recipe.preparationTime}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      click = !click;
                    });
                  },
                  icon: Image.asset((click == false)
                      ? 'lib/icons/like_off.png'
                      : 'lib/icons/like_on.png'),
                ),
              ],
            ),
            ListView.builder(
              itemCount: widget.recipe.ingredients.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [Text(widget.recipe.ingredients[index])],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
