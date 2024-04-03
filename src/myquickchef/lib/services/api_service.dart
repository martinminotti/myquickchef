import "dart:convert";
import "dart:io";

import "package:camera/camera.dart";
import "package:dio/dio.dart";
import "package:myquickchef/constants/api_constants.dart";

class ApiService {
  final Dio _dio = Dio();

  Future<String> encodeImage(XFile image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<String> sendImageToGPT4Vision({
    required XFile image,
    int maxTokens = 50,
    String model = "gpt-4-vision-preview",
  }) async {
    final String base64Image = await encodeImage(image);
    final imageDataUrl = "data:image/jpeg;base64,$base64Image";
    try {
      final response = await _dio.post(
        "$BASE_URL/chat/completions",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $API_KEY1",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode({
          "model": model,
          "messages": [
            {
              "role": "system",
              "content": "You have to give concise and short answers"
            },
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "GPT, your task is to analyze any image of a food and ingredients I provide, and detect all the name of the featured foods. Respond strictly with the list of the ingredients separeted by a comma. If a food is unrecognizable, reply with \"I don\"t know\". If the image is not food-related, say \"Please pick another image\"",
                },
                {
                  "type": "image_url",
                  "image_url": {"url": imageDataUrl}
                }
              ],
            },
          ],
          "max_tokens": maxTokens,
        }),
      );
      final jsonResponse = response.data;

      if (jsonResponse["error"] != null) {
        print(jsonResponse["error"]["message"]);
        throw HttpException(jsonResponse["error"]["message"]);
      }
      return jsonResponse["choices"][0]["message"]["content"];
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }

  Future<String> sendIngredientsToGPT3({
    required String ingredients,
    int maxTokens = 4000,
    String model = "gpt-3.5-turbo",
  }) async {
    try {
      final response = await _dio.post(
        "$BASE_URL/chat/completions",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $API_KEY2",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode({
          "model": model,
          "messages": [
            {
              "role": "system",
              "content": "You have to give concise and short answers"
            },
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "GPT, your task is to provide 3 easy-to-cook recipes with precision in JSON format composed of a \"recipes\" key a list where each value is a recipe that has 3 keys(name, ingredients, instructions). Using this list of food and ingredients: $ingredients. Respond strictly with the name of the recipe, the list of ingredients (including the each one quantity to use), and the instructions. Everything must be written on a single line and each one must have \n for every item. If necessary, be clear on how to execute the preparation.",
                }
              ],
            },
          ],
          "max_tokens": maxTokens,
        }),
      );
      final jsonResponse = response.data;

      if (jsonResponse["error"] != null) {
        print(jsonResponse["error"]["message"]);
        throw HttpException(jsonResponse["error"]["message"]);
      }
      print(jsonResponse);
      return jsonResponse["choices"][0]["message"]["content"];
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }
}