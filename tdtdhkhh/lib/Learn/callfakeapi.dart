import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageApp4(),
    );
  }
}

class HomePageApp4 extends StatefulWidget {
  const HomePageApp4({Key? key}) : super(key: key);

  @override
  _HomePageApp4State createState() => _HomePageApp4State();
}

class _HomePageApp4State extends State<HomePageApp4> {
  late Future<List<Photo>> lsPhoto;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsPhoto = Photo.fetchData();
    }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lsPhoto,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data as List<Photo>;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                Photo p = data[index];
                return Card(
                  child: Column(
                    children: [
                      Image.network(p.thumbnailUrl),
                      Text(p.title)
                    ],
                  )
                );
              });
          }
          else{
            return CircularProgressIndicator();
          }
        },

      ),
    );
  }
}
class Photo{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({required this.albumId, required this.id, required this.title, required this.url, required this.thumbnailUrl});

  static Future<List<Photo>> fetchData() async {
    String url="https://jsonplaceholder.typicode.com/photos";
    var client = http.Client();
    var reponse = await client.get(Uri.parse(url));
    if(reponse.statusCode == 200){
      var result = reponse.body;
      var jsonData = jsonDecode(result);//cast<List<Map<String,dynamic>>>();
      List<Photo> ls=[];
      for(var item in jsonData){
        Photo p = new Photo(
            albumId: item['albumId'],
            id: item['id'],
            title: item['title'],
            url: item['url'],
            thumbnailUrl: item['thumbnailUrl']);
        ls.add(p);
      }
      return ls;
    }
    else{
      throw Exception("Lỗi lấy dữ liệu. Chi tiết: ${reponse.statusCode}");
    }
  }
}
