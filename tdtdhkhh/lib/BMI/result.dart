import 'package:flutter/material.dart';
import 'BMI.dart';
import 'formula.dart';

class ResultPage extends StatefulWidget {
  double height ;
  double weight ;
  double age ;

ResultPage({ @required this.weight,@required this.height,this.age});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
Logic logic= Logic();
double bmiResult = 0;
  @override
  void initState() {
  bmiResult = logic.calculateBMI(widget.height, widget.weight);

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Text(
              "BMI Result",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "$bmiResult",
            )
          ],
        ));
  }

}
