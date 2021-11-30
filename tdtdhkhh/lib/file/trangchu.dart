import 'package:flutter/material.dart';

class TrangChu extends StatelessWidget {
  const TrangChu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello",
      home: MaterialBasic(),
    );
  }
}

class MaterialBasic extends StatefulWidget {
  const MaterialBasic({Key? key}) : super(key: key);

  @override
  _MaterialBasicState createState() => _MaterialBasicState();
}

class _MaterialBasicState extends State<MaterialBasic> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        leading: Icon(Icons.home, size: 30,color: Colors.amber,),
        actions: [
          IconButton(onPressed: (){
            var snack = SnackBar(content: Text("Alert content"));
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }, icon: Icon(Icons.add_alert_rounded)),
          IconButton(onPressed: (){
            var snack = SnackBar(content: Row(
              children: [
                Icon(Icons.add_alert_rounded),
                Text("Alert content")
              ],
            ));
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }, icon: Icon(Icons.login))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Dem: $count",style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  tooltip: "Call me now",
                  onPressed: (){

                  },
                  icon: Icon(Icons.call, size: 40,color: Colors.blue,)),
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.place,size: 40,color: Colors.red,)),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            count++;
            print(count);
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
