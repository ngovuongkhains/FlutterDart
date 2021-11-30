import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyApp6 extends StatelessWidget {
  const MyApp6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageApp4(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePageApp4 extends StatefulWidget {
  const HomePageApp4({Key? key}) : super(key: key);

  @override
  _HomePageApp4State createState() => _HomePageApp4State();
}

class _HomePageApp4State extends State<HomePageApp4> {

  late Future<List<Product>> ls;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ls = Product.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    showButtonDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController customController = TextEditingController();
          return AlertDialog(
            title: Text('Số lượng mua: ', style: TextStyle(fontSize: 14),),
            content: TextField(
              controller: customController,
              decoration: InputDecoration(hintText: "Điền số lượng"),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined),
            const Text(" Shop 3.14"),

          ],
        ),
      ),
      body: FutureBuilder(
        future: ls,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Có lỗi xảy ra!'),
            );
          }
          else if (snapshot.hasData){
            var data = snapshot.data as List<Product>;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final p = data[index];
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(5),
                    color: Colors.white,
                    /*decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                    ),*/
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.category.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.lightBlue, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Center(
                            child: ClipRRect(
                              child: Image.network(p.image, width: 100, fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.title.substring(0,17),
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(p.price.toString()+" \$",
                                  style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => showButtonDialog(context)),
                                ],
                              ),
                            )

                          ],
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
  final double price;
  final String description;
  final String category;
  final String image;
  //final Rating rating;

  Product(
      {required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        //required this.rating

      });

  static Future<List<Product>> fetchData() async {
    String url = "https://fakestoreapi.com/products?limit=100";
    var client = http.Client();
    var reponse = await client.get(Uri.parse(url));

    if (reponse.statusCode == 200) {
      var result = reponse.body;
      var jsonData = jsonDecode(result);
      print(result);
      List<Product> ls = [];
      for (var item in jsonData) {
        print(item);
        Product product = Product(
          id: item['id'] as int,
          title: item['title'] as String,
          price: item['price'] as double,
          description: item['description'] as String,
          category: item['category'] as String,
          image: item['image'] as String,
          //rating: item['rating'] as Rating
        );
        ls.add(product);
      }
      return ls;
    } else {
      throw Exception("lỗi lấy dữ liệu chi tiết : ${reponse.statusCode}");
    }
  }
}

class Rating {
  late double rate;
  late int count;

  Rating(this.rate, this.count);

  Rating.fromJson(Map<String, dynamic> item) {
    rate = item['rate'];
    count = item['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}