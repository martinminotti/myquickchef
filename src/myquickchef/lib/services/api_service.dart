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
                      "GPT, il tuo compito è quello di fornirmi 3 ricette facili da cucinare, e di immagazzinarle con precisone in formato JSON composto da una chiave \"ricette\", una lista dove ogni valore è una ricetta che ha 6 chiavi (name, ingredients, category, preparationTime, presentation, steps). Devi farlo usando questa lista di cibo ed ingredienti: $ingredients. Rispondi precisamente con il nome della ricetta, la lista degli ingredienti (includendo nella stessa ed unica stringa la quantità da usare di ciascuno), una categoria sensata per il tipo di ricetta, un tempo approssimativo di preparazione, un breve riassunto generale di quello che sarà il piatto, ed infine le istruzioni numerate, passaggio per passaggio, per eseguire la preparazione della ricetta. Se necessario, sii esaustivo su come eseguire la preparazione del piatto. Rispondi sempre in Italiano.",
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
