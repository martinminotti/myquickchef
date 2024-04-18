// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/services/file_recipes.dart';
import 'package:myquickchef/widgets/favorite_card.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Recipe> favoritesList = [];
  List<String> recents = [];
  List<Recipe> searchResults = [];
  @override
  void initState() {
    super.initState();
    loadList().then((updatedList) {
      setState(() {
        favoritesList = updatedList;
        searchResults = favoritesList;
      });
    });
  }

  void onDelete(int index) {
    setState(() {
      favoritesList.removeAt(index);
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      query == ""
          ? searchResults = favoritesList
          : searchResults = favoritesList
              .where((item) =>
                  item.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return favoritesList.isEmpty
        ? const Center(
            child: Text(
            "Nessun preferito",
            textAlign: TextAlign.center,
          ))
        : SafeArea(
            child: Column(
              children: [
                Theme(
                  data: ThemeData(primaryColor: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SearchAnchor(builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        controller: controller,
                        hintText: "Cerca ricetta",
                        textStyle: const MaterialStatePropertyAll<TextStyle>(
                            TextStyle(fontSize: 19)),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(244, 245, 247, 1)),
                        hintStyle: const MaterialStatePropertyAll<TextStyle>(
                            TextStyle(color: Color.fromRGBO(155, 163, 175, 1))),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onChanged: onQueryChanged,
                        onSubmitted: (value) {
                          setState(() {
                            recents.add(value);
                          });
                        },
                        leading: const Icon(Icons.search),
                        elevation: MaterialStateProperty.all<double?>(0.0),
                      );
                    }, suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(recents.length,
                          (int index) {
                        return ListTile(
                          title: Text(recents[index]),
                          onTap: () {
                            setState(() {
                              controller.closeView(recents[index]);
                            });
                          },
                        );
                      });
                    }),
                  ),
                ),
                const Divider(
                  color: Color.fromRGBO(244, 245, 247, 10),
                  thickness: 4,
                  indent: 1,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: GridView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return FavoriteCard(
                          recipe: searchResults[index],
                          onDelete: () => onDelete(index),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 280,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
