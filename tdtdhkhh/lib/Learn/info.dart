import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp8 extends StatelessWidget {
  const MyApp8({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FetchData2()
    );
  }
}
class FetchData2 extends StatefulWidget {
  const FetchData2({Key? key}) : super(key: key);

  @override
  _FetchData2State createState() => _FetchData2State();
}
class _FetchData2State extends State<FetchData2> {

  late Future<List<Product>> lsProduct;

  @override
  void initState(){
    super.initState();
    lsProduct = Product.fetchData();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Proflie",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 50, 70, 1.0)
            )
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: lsProduct,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (snapshot.hasData)
          {
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
                itemBuilder: (BuildContext context, int index)
                {
                  Product p = data[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Image.network(p.picture, height: 180, width: 150,),
                        Text("Name: "       +p.name.toString()),
                        Text("Gender: "     +p.gender.toString()),
                        Text("Location: "   +p.location.toString()),
                        Text("Email: "      +p.email.toString()),
                        Text("Login: "       +p.login.toString()),
                        Text("Dob: "     +p.dob.toString()),
                        Text("Registered: "   +p.registered.toString()),
                        Text("Phone: "      +p.phone.toString()),
                        Text("Cell: "       +p.cell.toString()),
                        Text("Id: "     +p.id.toString()),
                        Text("Nat: "      +p.nat.toString()),




                      ],

                    ),
                  );
                }
            );
          }
          else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
class Product{
  final String gender;
  final String name;
  final String location;
  final String email;
  final String login;
  final String dob;
  final String registered;
  final String phone;
  final String cell;
  final String id;
  final String picture;
  final String nat;

  Product({required this.gender,required this.name,required this.location,required this.email,required this.login,required this.dob,required this.registered,required this.phone,required this.cell,required this.id,required this.picture,required this.nat});


  static Future<List<Product>> fetchData() async {
    String url = "https://randomuser.me/api/";
    var client = http.Client();
    var reponse = await client.get(Uri.parse(url));
    //print(reponse);
    if(reponse.statusCode == 200){
      var result = reponse.body;
      //print(result);
      var jsonData = jsonDecode(result);//.cast<List<Map<String, dynamic>>>();
      //print(jsonData.length);
      List<Product> ls = [];
      for(var item in jsonData){
        //print(item);
        Product p = new Product(
            gender: item['gender'],
            name: item['name'],
            location: item['location'],
            email : item['email'],
            login  : item['login'],
            dob  : item['dob'],
            registered : item['registered'],
            phone: item['phone'],
            cell   : item['cell'],
            id   : item['id'],
            picture : item['picture'],
            nat : item['nat']);


        ls.add(p);
      }
      return ls;
    }
    else{
      throw Exception("Lỗi lấy dữ liệu. Chi tiết: ${reponse.statusCode}");
    }
  }
}
