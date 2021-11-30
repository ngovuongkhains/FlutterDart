import 'dart:convert';

import 'package:noob/Product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Product_model.dart';
import 'package:http/http.dart' as http;

class ScreenShoppe extends StatelessWidget {
  const ScreenShoppe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuildShoppe(),
    );
  }
}

class BuildShoppe extends StatefulWidget {
  const BuildShoppe({Key? key}) : super(key: key);

  @override
  _BuildShoppeState createState() => _BuildShoppeState();
}

class _BuildShoppeState extends State<BuildShoppe> {
  late Product p;
  late int count = 0;
  late Size size;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // var data = snapshot.data;
            return GridView.count(
              padding: EdgeInsets.all(7),
              crossAxisCount: 2,
              children: List.generate(snapshot.data.length, (index) {
                // Product p = data[index];
                return buildProduct(snapshot.data[index]);
              }),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildProduct(Product p) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(p.imgge,
                height: size.height * 0.129,
                width: size.width * 0.27,
                fit: BoxFit.fill),
            SizedBox(height: 2),
            Text(
              p.title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${p.price}\$",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.amber[700],
                  ),
                ),
                buildMuaNgay(),
                buildGioHang()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMuaNgay() {
    return GestureDetector(
      onTap: () {
        setState(() {
          count = 0;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: const Text('Mua hàng ngay'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            icon: Icon(Icons.add)),
                        Text("$count"),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 0) count--;
                              });
                            },
                            icon: Icon(Icons.minimize)),
                        SizedBox(width: 20)
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Để sau'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Mua'),
                      ),
                    ],
                  );
                }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
        child: Text("Mua ngay",
            style: TextStyle(fontSize: 14, color: Colors.white)),
        decoration: BoxDecoration(
            color: Colors.amber[700], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget buildGioHang() {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Thêm vào giỏ hàng'),
              content: const Text('Thêm vào nào hihihi (-_-)'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Để sau'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Thêm'),
                ),
              ],
            ),
          );
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.amber[700],
          size: 20,
        ));
  }
}