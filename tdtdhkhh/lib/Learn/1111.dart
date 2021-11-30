import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp7 extends StatelessWidget {
  const MyApp7({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FetchData1());
  }
}

class FetchData1 extends StatefulWidget {
  const FetchData1({Key? key}) : super(key: key);

  @override
  _FetchData1State createState() => _FetchData1State();
}

class _FetchData1State extends State<FetchData1> {
  late Future<List<Product>> lsProduct;

  @override
  void initState() {
    super.initState();
    lsProduct = Product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 50, 70, 1.0))),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: lsProduct,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List<Product>;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 10 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 400,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  Product p = data[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          p.image,
                          height: 180,
                          width: 150,
                        ),
                        Text(p.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Giá: " + p.price.toString() + "\$"),
                        Text("Category: " + p.category,
                            textAlign: TextAlign.center),
                        Text("Rate: " + p.rate.toString()),
                        Text("Count: " + p.count.toString()),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent,
                            ),
                            onPressed: () {},
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Product {
  final int id;
  final String title;
  final double price; //final double? price; cho phép price null
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rate,
      required this.count});

  //required this.rating

  static Future<List<Product>> fetchData() async {
    String url = "https://fakestoreapi.com/products?limit=100";
    var client = http.Client();
    var reponse = await client.get(Uri.parse(url));
    //print(reponse);
    if (reponse.statusCode == 200) {
      var result = reponse.body;
      //print(result);
      var jsonData = jsonDecode(result); //.cast<List<Map<String, dynamic>>>();
      //print(jsonData.length);
      List<Product> ls = [];
      for (var item in jsonData) {
        //print(item);
        Product p = new Product(
            id: item['id'],
            title: item['title'],
            price: double.parse(item['price'].toString()),
            description: item['description'],
            category: item['category'],
            image: item['image'],
            rate: item["rating"]["rate"],
            count: item["rating"]["count"]);
        //rating: item['rating'],
        //print(item);
        ls.add(p);
      }
      return ls;
    } else {
      throw Exception("Lỗi lấy dữ liệu. Chi tiết: ${reponse.statusCode}");
    }
  }
}
