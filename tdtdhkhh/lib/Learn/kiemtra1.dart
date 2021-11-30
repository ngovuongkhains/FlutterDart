import 'dart:convert';
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

Future<List<Article>> fetchData() async{
  String url = "https://newsapi.org/v2/everything?q=apple&from=2021-11-15&to=2021-11-15&sortBy=popularity&apiKey=be620e9326564691b8df9be08293fd85";
  var client = http.Client();
  var reponse = await client.get(Uri.parse(url));
  if (reponse.statusCode == 200) {
    var result = reponse.body;
    var jsonData = jsonDecode(result);
    print(jsonData);
    List<Article> ls = [];

    for(var item in jsonData){
      dynamic author = item["Article"]["author"];
      dynamic title = item["Article"]["title"];
      dynamic description = item["Article"]["description"];
      dynamic url = item["Article"]["url"];
      dynamic urlToImage = item["Article"]["urlToImage"];
      dynamic publishedAt = item["Article"]["publishedAt"];
      dynamic content = item["Article"]["content"];
      dynamic id = item["Source"]["id"];
      dynamic name = item["Source"]["name"];
      Source source = new Source(id: id, name: name);
      Article article = new Article(
          source: source,
          author: author,
          title: title,
          description:
          description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content);

      Article p = new Article(
          source: source,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content);
      print("============================= $p");
      ls.add(p);
    }
  return ls;
  } else {
    return throw Exception('Không có dữ liệu');
  }
}