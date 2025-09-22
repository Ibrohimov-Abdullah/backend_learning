import "dart:convert";

import "package:http/http.dart" as http;
import "package:http/http.dart";



class Api {
  // baseurl
  // static kalit so'zi bizning clasimizdagi o'zgaruvchilarni obyekt yaratmasdan ishlatishga yordam beradi
  static const String baseUrl = "68c7efb15d8d9f514733a6c1.mockapi.io";
  static const String productsApi = "/products";


  // static - obyekt yaratmasdna ishlatishga yordam beradi
  static Future<String?> get(String api) async {

    final Uri url = Uri.http(baseUrl,api);
    final Response response = await http.get(url, headers: {
      "Content-Type": "application/json",
    },);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }




  static Future<String?> post(String api, Map<String, dynamic> body) async {
    final Uri url = Uri.http(baseUrl, api);

    final Response response = await http.post(url, headers: {
      "Content-Type": "application/json",
    }, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }


  static Future<String?> PUT(String api, Map<String, dynamic> body, Map<String, dynamic> param) async {
    final Uri url = Uri.https(baseUrl, api, param);

    final Response response = await http.put(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> delete(String api, String id, ) async {
    final Uri url = Uri.https(baseUrl, "$api/$id",);

    final Response response = await http.delete(url, headers: {
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  /// params

  static Map<String, String> emptyParams() => <String, String>{};

  /// body

  static Map<String, dynamic> bodyEmpty() => <String, dynamic>{};
}