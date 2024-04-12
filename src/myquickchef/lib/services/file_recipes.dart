import 'dart:convert';
import 'dart:io';
import 'package:myquickchef/models/recipe.dart';
import 'package:path_provider/path_provider.dart';

const fileName = "recipes.json";

Future<void> saveRecipe(Recipe recipe) async {
  List<Recipe> recipesList = await loadList();
  recipesList.add(recipe);
  final jsonWrite = jsonEncode({"recipes": recipesList});
  await writeFile(jsonWrite);
  return;
}

Future<void> deleteRecipe(Recipe recipe) async {
  List<Recipe> recipesList = await loadList();
  recipesList.remove(recipe);
  final jsonWrite = jsonEncode({"recipes": recipesList});
  await writeFile(jsonWrite);
  return;
}

Future<List<Recipe>> loadList() async {
  final stringRead = await readFile();

  final jsonRead = jsonDecode(stringRead!);
  final recipesList = List<Recipe>.from(
      jsonRead["recipes"].map<Recipe>((i) => Recipe.fromJson(i)));
  return recipesList;
}

Future<File> get _localFile async {
  final path = await _localPath;
  final file = File('$path/$fileName');
  if (await file.exists() == false) {
    await file.create();
    await file.writeAsString('{"recipes":[]}');
  }
  return file;
}

Future<String> get _localPath async {
  final directory = await getTemporaryDirectory();

  return directory.path;
}

Future<String?> readFile() async {
  try {
    final file = await _localFile;
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<File> writeFile(String json) async {
  final file = await _localFile;
  // Write the file
  return await file.writeAsString(json);
}
