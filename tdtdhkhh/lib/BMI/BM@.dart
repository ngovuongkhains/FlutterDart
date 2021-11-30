import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculate Your BMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int currentindex = 0;
  String result = "";
  double height = 0;
  double weight = 0;
  double age = 0;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xff000000),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.white),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    radioButton("Man", Colors.blue, 0),
                    radioButton("Woman", Colors.pink, 1),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff2a2a71),
                      border: Border.all(color: Color(0xff2a2a71)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "HEIGHT",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$height",
                              style: TextStyle(
                                fontSize: 35.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "cm",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                            value: height,
                            min: 0,
                            max: 250,
                            divisions: 250,
                            label: height.round().toString(),
                            onChanged: (height) =>
                                setState(() => this.height = height)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xff2a2a71),
                        border: Border.all(color: Color(0xff2a2a71)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "WEIGHT",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$weight",
                                style: TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "kg",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        weight++;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        weight--;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.do_not_disturb_on,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xff2a2a71),
                        border: Border.all(color: Color(0xff2a2a71)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "AGE",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$age",
                                style: TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        age++;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.do_not_disturb_on,
                                      size: 50,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: (){
                      setState((){
                        height = double.parse(heightController.value.text);
                        weight = double.parse(weightController.value.text);
                      });
                      calculateBMI(height, weight);
                    },
                    color: Colors.blue,
                    child: Text("Calculate",style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Your BMI is : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50.0,),
                Container(
                  width: double.infinity,
                  child: Text(
                    "$result",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ),
        ),
        backgroundColor: Colors.black,
      )
    );
  }
  void calculateBMI(double height, double weight){
    double finalresult = weight / (height * height/10000);
    String BMI = finalresult.toStringAsFixed(2);
    setState((){
      result = BMI;
    });
  }
  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            height: 80,
            child: FlatButton(
              color: currentindex == index ? color : Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                changeIndex(index);
              },
              child: Text(value,
                  style: TextStyle(
                    color: currentindex == index ? Colors.white : color,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
            )));
  }
}
