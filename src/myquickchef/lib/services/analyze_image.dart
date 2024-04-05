import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/services/api_service.dart';

Future<List<Recipe>?> analyzeImage(XFile image) async {
  //final res = await ApiService().sendImageToGPT4Vision(image: image);
  const res = "Olive oil, basil, parmesan cheese, garlic, pine nuts";
  print(res);
  if (res == "I don\'t know." || res == "Please pick another image.") {
    return null;
  }
  // final recipeList = jsonDecode('{"ricette": [{"name": "Pesto alla Genovese","ingredients": "Basilico (50g), Olio d oliva (100ml), Parmigiano (50g), Aglio (1 spicchio), Pinoli (30g)","category": "Primo piatto","preparationTime": "20 minuti","presentation": "Piatto di pasta fresca con pesto al basilico","steps": ["Lavare e asciugare le foglie di basilico.","Mettere nel frullatore il basilico, l aglio, i pinoli e il parmigiano, e frullare aggiungendo piano piano l olio fino ad ottenere una crema omogenea.","Cuocere la pasta al dente e condirla con il pesto preparato, aggiungendo un po di acqua di cottura se necessario.","Servire la pasta con una spolverata di formaggio grattugiato e foglie di basilico fresco."]},{"name": "Pesto alla Genovese","ingredients": "Basilico (50g), Olio d oliva (100ml), Parmigiano (50g), Aglio (1 spicchio), Pinoli (30g)","category": "Primo piatto","preparationTime": "20 minuti","presentation": "Piatto di pasta fresca con pesto al basilico","steps": ["Lavare e asciugare le foglie di basilico.","Mettere nel frullatore il basilico, l aglio, i pinoli e il parmigiano, e frullare aggiungendo piano piano l olio fino ad ottenere una crema omogenea.","Cuocere la pasta al dente e condirla con il pesto preparato, aggiungendo un po di acqua di cottura se necessario.","Servire la pasta con una spolverata di formaggio grattugiato e foglie di basilico fresco."]},{"name": "Pesto alla Genovese","ingredients": "Basilico (50g), Olio d oliva (100ml), Parmigiano (50g), Aglio (1 spicchio), Pinoli (30g)","category": "Primo piatto","preparationTime": "20 minuti","presentation": "Piatto di pasta fresca con pesto al basilico","steps": ["Lavare e asciugare le foglie di basilico.","Mettere nel frullatore il basilico, l aglio, i pinoli e il parmigiano, e frullare aggiungendo piano piano l olio fino ad ottenere una crema omogenea.","Cuocere la pasta al dente e condirla con il pesto preparato, aggiungendo un po di acqua di cottura se necessario.","Servire la pasta con una spolverata di formaggio grattugiato e foglie di basilico fresco."]}]}');
  final recipeList =
      jsonDecode(await ApiService().sendIngredientsToGPT3(ingredients: res));
  print(recipeList["ricette"]);
  try {
    final lista = List<Recipe>.from(
        recipeList["ricette"].map<Recipe>((i) => Recipe.fromMap(i)));
    print(lista);
  } catch (e) {
    print(e);
  }

  return recipeList;
}
