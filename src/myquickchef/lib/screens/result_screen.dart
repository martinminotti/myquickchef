import 'package:flutter/material.dart';
import 'package:myquickchef/main.dart';
import 'package:myquickchef/widgets/recipe_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  //List<Recipe> recipes = []; // Lista delle ricette
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(244, 245, 247, 100), width: 6),
          ),
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 90,
          leading: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
          ), //icona back
          centerTitle: true,
          title: const Text(
            'Risultati',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ), //text risultati
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: IconButton(
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        //utilizzo un widget per evitare lo stretching delle card durante l'overscroll della listview
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator(); // Prevent Overscroll Indication
            return true;
          },
          child: ListView.builder(
            scrollDirection: Axis.vertical, // Imposta la direzione orizzontale
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecipeCard(recipes[index],
                    false), // Utilizza la RecipeCard per ogni ricetta
              );
            },
          ),
        ));
  }
}
