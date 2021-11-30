import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Welcome {
  Welcome({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;
}

class NetworkRequest {
  static const String url = 'https://newsapi.org/v2/everything?q=apple&from=2021-11-15&to=2021-11-15&sortBy=popularity&apiKey=be620e9326564691b8df9be08293fd85';

  static List<Welcome> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Welcome> wc = list.map((model) => Welcome.fromJson(model)).toList();
    return tenphantutrongclass;
  }

  static Future<List<Welcome>> fetchProducts({int page = 1}) async {
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