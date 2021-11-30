import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class List_Basic extends StatelessWidget{
  const List_Basic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "List basic",
      home: ListBasic(),
    );
  }
}
class ListBasic extends StatefulWidget{
  const ListBasic({Key? key}) : super (key:key);
  @override
  _ListBasicState createState() => _ListBasicState();
}

class _ListBasicState extends State<ListBasic>{
  Iterable<WordPair> data = generateWordPairs().take(100);
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title : Text("Danh sách cơ bản"),
          leading: Icon(Icons.line_style),
        ),
        body: ListView.builder(
          itemCount: data.length,

          itemBuilder: (BuildContext context,int index){
            WordPair word = data.elementAt(index);
            return Card(
              elevation: 0,
              child: ListTile(
                  title: Text(word.asCamelCase),
                  leading: CircleAvatar(
                    child: Text((index+1).toString(),style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.black,
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.edit),),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.delete),),
                    ],
                  )
              ),
            );
          },
        )
    );
  }
}
