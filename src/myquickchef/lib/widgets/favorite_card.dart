import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/screens/recipe_details_screen.dart';

class FavoriteCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onDelete;
  const FavoriteCard({super.key, required this.recipe, this.onDelete});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipe: widget.recipe,
              onDelete: widget.onDelete,
            ),
          ),
        )
            .then((_) {
          setState(() {});
        });
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(32.0),
                child: Image(
                  image: Image.file(File(widget.recipe.image!)).image,
                )),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                widget.recipe.name,
                style: const TextStyle(
                  color: Colors.black87,
                  letterSpacing: 0.5,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    //faccio una condizione perchè se il nome della categoria è troppo lungo sfora nella card e da un errore, possiamo chiedere di generare un categoria con lunghezza limitata
                    '${widget.recipe.category} • ${widget.recipe.preparationTime}'
                                .length >
                            30
                        ? '${widget.recipe.category}'
                        : '${widget.recipe.category} • ${widget.recipe.preparationTime}',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
