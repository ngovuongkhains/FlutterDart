import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String imgge;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imgge,
    required this.rating,
  });
}

class Rating {
  final dynamic rate;
  final dynamic coutn;
  Rating({required this.rate, required this.coutn});
}

Future<List<Product>> fetchData() async {
  String url = "https://fakestoreapi.com/products?limit=100";
  var client = http.Client();
  var reponse = await client.get(Uri.parse(url));
  if (reponse.statusCode == 200) {
    var result = reponse.body;
    var jsonData = jsonDecode(result);
    print(jsonData);
    List<Product> ls = [];

    for (var item in jsonData) {
      dynamic rate = item["rating"]["rate"];
      dynamic count = item["rating"]["count"];
      Rating rating = new Rating(rate: rate, coutn: count);
      Product p = new Product(
        id: item["id"],
        title: item["title"],
        price: item["price"],
        description: item["description"],
        category: item["category"],
        imgge: item["image"],
        rating: rating,
      );

      print("============================= $p");
      ls.add(p);
    }
    return ls;
  } else {
    return throw Exception('Không có dữ liệu');
  }
}