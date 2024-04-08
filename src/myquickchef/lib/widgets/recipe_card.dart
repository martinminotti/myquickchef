import 'package:flutter/material.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/screens/recipe_details_screen.dart';
import 'package:myquickchef/services/file_recipes.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  RecipeCard(this.recipe, {super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipe: widget.recipe,
            ),
          ),
        )
            .then((_) {
          setState(() {});
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            //per il bordo
            side: const BorderSide(
              color: Color.fromRGBO(208, 219, 234, 100),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16)),
        elevation: 3, //elevazione card
        child: Container(
          //metto tutta la card dentro un container per il colore di sfondo e il border che deve coincidere con quello della card
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: <Widget>[
            ListTile(
              //per fare il titolo, sottotitolo e button del like
              title: Padding(
                //titolo
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(widget.recipe.name,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(62, 84, 129, 100),
                        height: 1.0,
                        fontWeight: FontWeight.w900)),
              ),
              subtitle: Padding(
                //sottotitolo
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                    '${widget.recipe.category} • ${widget.recipe.preparationTime}',
                    style: const TextStyle(fontSize: 18)),
              ),
              trailing: IconButton(
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
            ),
            Container(
              //container per contenere solo la presentazione della ricetta
              color: Colors.transparent,
              //container per la presentazione
              padding:
                  const EdgeInsets.only(left: 15.0, top: 8.0, bottom: 20.0),
              child: Text(
                widget.recipe.summary,
                style: const TextStyle(height: 1.2, fontSize: 18),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
