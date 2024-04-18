import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/services/api_service.dart';

Future<List<Recipe>?> analyzeImage(XFile image) async {
  final res = await ApiService().sendImageToGPT4Vision(image: image);
  //const res = "Olive oil, parmesan cheese, pasta, lemon, shrimps, meat";
  print(res);
  if (res == "null") {
    return null;
  }
  // final jsonList = jsonDecode('{"recipes": [{"name": "Pesto alla Genovese","ingredients": ["Basilico (50g)", "Olio d oliva (100ml)", "Parmigiano (50g)", "Aglio (1 spicchio)", "Pinoli (30g)"],"category": "Primo piatto","preparationTime": "20 minuti","summary": "Piatto di pasta fresca con pesto al basilico","steps": ["Lavare e asciugare le foglie di basilico.","Mettere nel frullatore il basilico, l aglio, i pinoli e il parmigiano, e frullare aggiungendo piano piano l olio fino ad ottenere una crema omogenea.","Cuocere la pasta al dente e condirla con il pesto preparato, aggiungendo un po di acqua di cottura se necessario.","Servire la pasta con una spolverata di formaggio grattugiato e foglie di basilico fresco."]},{"name": "Pesto alla Genovese","ingredients": ["Basilico (50g)", "Olio d oliva (100ml)", "Parmigiano (50g)", "Aglio (1 spicchio)", "Pinoli (30g)"],"category": "Primo piatto","preparationTime": "20 minuti","summary": "Piatto di pasta fresca con pesto al basilico","steps": ["Lavare e asciugare le foglie di basilico.","Mettere nel frullatore il basilico, l aglio, i pinoli e il parmigiano, e frullare aggiungendo piano piano l olio fino ad ottenere una crema omogenea.","Cuocere la pasta al dente e condirla con il pesto preparato, aggiungendo un po di acqua di cottura se necessario.","Servire la pasta con una spolverata di formaggio grattugiato e foglie di basilico fresco."]},{"name": "Pesto alla Genovese","ingredients": ["Basilico (50g)", "Olio d oliva (100ml)", "Parmigiano (50g)", "Aglio (1 spicchio)", "Pinoli (30g)"],"category": "Primo piatto","preparationTime": "20 minuti","summary": "Piatto di pasta fresca con pesto al basilico","steps": ["Lavare e asciugare le foglie di basilico.","Mettere nel frullatore il basilico, l aglio, i pinoli e il parmigiano, e frullare aggiungendo piano piano l olio fino ad ottenere una crema omogenea.","Cuocere la pasta al dente e condirla con il pesto preparato, aggiungendo un po di acqua di cottura se necessario.","Servire la pasta con una spolverata di formaggio grattugiato e foglie di basilico fresco."]}]}');
  final jsonList =
      jsonDecode(await ApiService().sendIngredientsToGPT3(ingredients: res));
  print(jsonList["recipes"]);
  final recipesList = List<Recipe>.from(
      jsonList["recipes"].map<Recipe>((i) => Recipe.fromMap(i)));
  print(recipesList);

  return recipesList;
}
