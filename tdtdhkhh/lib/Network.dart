// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';

class NetworkRequest {
  static const String url = 'https://newsapi.org/v2/everything?q=apple&from=2021-11-15&to=2021-11-15&sortBy=popularity&apiKey=be620e9326564691b8df9be08293fd85';

  static List<Articles> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Articles> articless =
    list.map((model) => Articles.fromJson(model)).toList();
    return articless;
  }

  static Future<List<Articles>> fetchProducts({int page = 1}) async {
    final response = await http.get('$url');
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Error');
    }
  }
}
