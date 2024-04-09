import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:myquickchef/services/file_recipes.dart';
import 'package:myquickchef/services/get_image.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({required this.recipe, super.key});

  final Recipe recipe;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  var click = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () async {
            await Navigator.maybePop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: widget.recipe.image != null
          ? showRecipeDetails()
          : FutureBuilder(
              future: getImage(widget.recipe),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  widget.recipe.image = snapshot.data;
                  return showRecipeDetails();
                } else {
                  return const Center(
                      child: Text(
                    "Image Error",
                    textAlign: TextAlign.center,
                  ));
                }
              },
            ),
    );
  }

  Container showRecipeDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image(
                image: Image.file(File(widget.recipe.image!)).image,
              )),
              const Divider(
                color: Colors.grey,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              Text(widget.recipe.name),
              Text(
                  "${widget.recipe.category} • ${widget.recipe.preparationTime}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.recipe.favorite = !widget.recipe.favorite;
                        if (widget.recipe.favorite) {
                          saveRecipe(widget.recipe);
                        } else {
                          deleteRecipe(widget.recipe);
                        }
                      });
                    },
                    icon: Image.asset((widget.recipe.favorite)
                        ? 'lib/icons/like_on.png'
                        : 'lib/icons/like_off.png'),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              const Text("Ingredienti"),
              BulletedList(
                crossAxisAlignment: CrossAxisAlignment.start,
                bulletColor: Colors.black87,
                listItems: widget.recipe.ingredients,
                bulletType: BulletType.conventional,
              ),
              const Divider(
                color: Colors.grey,
                height: 30,
                thickness: 4,
                indent: 1,
              ),
              const Text("Ricetta"),
              BulletedList(
                crossAxisAlignment: CrossAxisAlignment.start,
                bulletColor: Colors.black87,
                listItems: widget.recipe.steps,
                bulletType: BulletType.numbered,
              )
            ],
          ),
        ],
      ),
    );
  }
}
