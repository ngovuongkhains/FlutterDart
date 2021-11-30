import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()

class MyApp81 extends StatelessWidget {
  const MyApp81({Key? key}) : super(key: key);

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
class Welcome {
  Welcome({
    required this.results,
    required this.info,
  });

  List<Result> results;
  Info info;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "info": info.toJson(),
  };
}

class Info {
  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  String seed;
  int results;
  int page;
  String version;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    seed: json["seed"],
    results: json["results"],
    page: json["page"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "seed": seed,
    "results": results,
    "page": page,
    "version": version,
  };
}

class Result {
  Result({
    required this.gender,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  String gender;
  Location location;
  String email;
  Login login;
  Dob dob;
  Dob registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    gender: json["gender"],
    location: Location.fromJson(json["location"]),
    email: json["email"],
    login: Login.fromJson(json["login"]),
    dob: Dob.fromJson(json["dob"]),
    registered: Dob.fromJson(json["registered"]),
    phone: json["phone"],
    cell: json["cell"],
    id: Id.fromJson(json["id"]),
    picture: Picture.fromJson(json["picture"]),
    nat: json["nat"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "location": location.toJson(),
    "email": email,
    "login": login.toJson(),
    "dob": dob.toJson(),
    "registered": registered.toJson(),
    "phone": phone,
    "cell": cell,
    "id": id.toJson(),
    "picture": picture.toJson(),
    "nat": nat,
  };
}

class Dob {
  Dob({
    required this.date,
    required this.age,
  });

  DateTime date;
  int age;

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
    date: DateTime.parse(json["date"]),
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "age": age,
  };
}

class Id {
  Id({
    required this.name,
    required this.value,
  });

  String name;
  String value;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}

class Location {
  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  Street street;
  String city;
  String state;
  String country;
  int postcode;
  Coordinates coordinates;
  Timezone timezone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    street: Street.fromJson(json["street"]),
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postcode: json["postcode"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    timezone: Timezone.fromJson(json["timezone"]),
  );

  Map<String, dynamic> toJson() => {
    "street": street.toJson(),
    "city": city,
    "state": state,
    "country": country,
    "postcode": postcode,
    "coordinates": coordinates.toJson(),
    "timezone": timezone.toJson(),
  };
}

class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  String latitude;
  String longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Street {
  Street({
    required this.number,
    required this.name,
  });

  int number;
  String name;

  factory Street.fromJson(Map<String, dynamic> json) => Street(
    number: json["number"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
  };
}

class Timezone {
  Timezone({
    required this.offset,
    required this.description,
  });

  String offset;
  String description;

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    offset: json["offset"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "description": description,
  };
}

class Login {
  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    uuid: json["uuid"],
    username: json["username"],
    password: json["password"],
    salt: json["salt"],
    md5: json["md5"],
    sha1: json["sha1"],
    sha256: json["sha256"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "username": username,
    "password": password,
    "salt": salt,
    "md5": md5,
    "sha1": sha1,
    "sha256": sha256,
  };
}

class Picture {
  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  String large;
  String medium;
  String thumbnail;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    large: json["large"],
    medium: json["medium"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "large": large,
    "medium": medium,
    "thumbnail": thumbnail,
  };
}
