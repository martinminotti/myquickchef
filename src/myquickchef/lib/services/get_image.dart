import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:myquickchef/models/recipe.dart';
import 'package:myquickchef/services/api_service.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getImage(Recipe recipe) async {
  // final url = await ApiService().generateImage(recipeName: recipe.name);
  final url =
      "https://www.giallozafferano.it/images/ricette/0/5/foto_hd/hd650x433_wm.jpg";
  // final image = Image.network(url);
  String tempPath = (await getTemporaryDirectory()).path;
  final res =
      await Dio().get(url, options: Options(responseType: ResponseType.bytes));
  File file =
      await File('$tempPath/images/${url.split("?")[0].split("/").last}')
          .create(recursive: true);
  await file.writeAsBytes(res.data);
  // recipe.image = file.path;
  // final image = Image.file(file);
  return file.path;
}
