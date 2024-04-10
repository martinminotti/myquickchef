import "dart:convert";
import "dart:io";

import "package:camera/camera.dart";
import "package:dio/dio.dart";
import "package:flutter/widgets.dart";
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
          "functions": [
            {
              "name": "createRecipesObject",
              "parameters": {
                "type": "object",
                "properties": {
                  "recipes": {
                    "type": "object",
                    "properties": {
                      "name": {"type": "string"},
                      "category": {"type": "string"},
                      "summary": {"type": "string"},
                      "preparationTime": {"type": "string"},
                      "ingredients": {
                        "type": "array",
                        "items": {"type": "string"}
                      },
                      "steps": {
                        "type": "array",
                        "items": {"type": "string"}
                      },
                    }
                  },
                },
                "required": [
                  "recipes",
                ]
              }
            }
          ],
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
                      "GPT, il tuo compito è quello di generare fino almeno 3 ricette usando la funzione createRecipesObject. Devi farlo usando in parte o anche tutta questa lista di ingredienti: $ingredients. Rispondi precisamente con il nome della ricetta, la lista degli ingredienti, una categoria sensata per il tipo di ricetta, un tempo approssimativo di preparazione, un breve riassunto generale di quello che sarà il piatto, ed infine le istruzioni numerate, passaggio per passaggio, per eseguire la preparazione della ricetta. Se necessario, sii esaustivo su come eseguire la preparazione del piatto. Rispondi sempre in Italiano.",
                }
              ],
            },
          ],
          "function_call": {"name": "createRecipesObject"},
          "max_tokens": maxTokens,
        }),
      );
      final jsonResponse = response.data;

      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      return jsonResponse["choices"][0]["message"]["function_call"]
          ["arguments"];
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }

  Future<String> generateImage({
    required String recipeName,
    String size = "256x256",
    String model = "dall-e-2",
  }) async {
    try {
      final response = await _dio.post(
        "$BASE_URL/images/generations",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $API_KEY2",
          },
        ),
        data: jsonEncode({
          "model": model,
          "prompt": recipeName,
          "n": 1,
          "size": size,
        }),
      );
      final imageResponse = response.data;
      print(imageResponse);
      if (imageResponse["error"] != null) {
        throw HttpException(imageResponse["error"]["message"]);
      }
      return imageResponse["data"][0]["url"];
    } catch (e) {
      print(e);
      throw Exception("Error: $e");
    }
  }
}
