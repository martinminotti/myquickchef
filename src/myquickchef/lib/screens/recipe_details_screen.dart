import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:myquickchef/services/file_recipes.dart';
import 'package:myquickchef/services/get_image.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onDelete;
  const RecipeDetailsScreen({super.key, required this.recipe, this.onDelete});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  var click = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: widget.recipe.image != null
          ? showRecipeDetails()
          : FutureBuilder(
              future: getImage(widget.recipe),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Image.asset("lib/icons/loading_mqc.gif"));
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

  Scaffold showRecipeDetails() {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back_ios_rounded),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  backgroundColor: MaterialStateProperty.all(
                      Colors.transparent.withOpacity(0.15)),
                ),
                onPressed: () async {
                  await Navigator.maybePop(context);
                },
              ),
              expandedHeight: 300.0,
              floating: false,
              pinned: false,
              stretch: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(36.0),
                      bottomRight: Radius.circular(36.0),
                    ),
                    child: Image(
                      image: Image.file(File(widget.recipe.image!)).image,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.white,
                    height: 20,
                    thickness: 4,
                    indent: 150,
                    endIndent: 150,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 8, bottom: 20),
                      child: Text(
                        widget.recipe.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 8, bottom: 10),
                    child: Text(
                      "${widget.recipe.category}  •  ${widget.recipe.preparationTime}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.recipe.favorite = !widget.recipe.favorite;
                            if (widget.recipe.favorite) {
                              saveRecipe(widget.recipe);
                            } else {
                              deleteRecipe(widget.recipe);
                              widget.onDelete!();
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
                    color: Color.fromRGBO(244, 245, 247, 10),
                    thickness: 11,
                    indent: 1,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 8, bottom: 20, top: 20),
                      child: const Text(
                        "Ingredienti",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  BulletedList(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    bulletColor: Color.fromARGB(255, 6, 185, 239),
                    listItems: widget.recipe.ingredients,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    bulletType: BulletType.conventional,
                  ),
                  const Divider(
                    color: Color.fromRGBO(244, 245, 247, 10),
                    thickness: 11,
                    indent: 1,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 8, bottom: 20, top: 20),
                      child: const Text(
                        "Ricetta",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  BulletedList(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    bulletColor: Colors.black87,
                    listItems: widget.recipe.steps,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    bulletType: BulletType.numbered,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
