import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'DataContainer.dart';
import 'ContainerBoxes.dart';

const activeColor = Color(0xFF0073dd);
const inActiveColor = Color(0xFF212121);

class BMI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF000000),
          scaffoldBackgroundColor: Color(0xFF000000),
        ),
        home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color maleBoxColor = activeColor;
  Color femaleBoxColor = inActiveColor;
  int height = 180;
  int weight = 70;
  int age = 18;
  String result = "";
  String resultDetail = "result here";
  double bmi = 0;

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (maleBoxColor == inActiveColor) {
        maleBoxColor = activeColor;
        femaleBoxColor = inActiveColor;
      } else {
        maleBoxColor = inActiveColor;
        femaleBoxColor = activeColor;
      }
    } else {
      if (femaleBoxColor == inActiveColor) {
        femaleBoxColor = activeColor;
        maleBoxColor = inActiveColor;
      } else {
        femaleBoxColor = inActiveColor;
        maleBoxColor = activeColor;
      }
    }
  }

  String calculatorBMI(int weight, int height) {
    bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  String getInterpretation(double bmi) {
    if (bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateBoxColor(1);
                      });
                    },
                    child: ContainerBoxes(
                      boxColor: maleBoxColor,
                      childwidget: DataContainer(
                        title: 'MALE',
                        icon: FontAwesomeIcons.mars,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        updateBoxColor(2);
                      });
                    },
                    child: ContainerBoxes(
                      boxColor: femaleBoxColor,
                      childwidget: DataContainer(
                        title: 'FEMALE',
                        icon: FontAwesomeIcons.venus,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ContainerBoxes(
            boxColor: inActiveColor,
            childwidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HEIGHT',
                  style: textStyle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      height.toString(),
                      style: textStyle2,
                    ),
                    Text(
                      'cm',
                      style: textStyle1,
                    ),
                  ],
                ),
                Slider(
                  value: height.toDouble(),
                  min: 0,
                  max: 300,
                  activeColor: activeColor,
                  inactiveColor: inActiveColor,
                  onChanged: (double newValue) {
                    setState(() {
                      height = newValue.round();
                    });
                  },
                )
              ],
            ),
          )),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ContainerBoxes(
                    boxColor: inActiveColor,
                    childwidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: textStyle1,
                        ),
                        Text(
                          weight.toString(),
                          style: textStyle2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              backgroundColor: activeColor,
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            FloatingActionButton(
                              backgroundColor: activeColor,
                              child: Icon(
                                FontAwesomeIcons.minus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (weight > 0) {
                                    weight--;
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ContainerBoxes(
                    boxColor: inActiveColor,
                    childwidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: textStyle1,
                        ),
                        Text(
                          age.toString(),
                          style: textStyle2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              backgroundColor: activeColor,
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            FloatingActionButton(
                              backgroundColor: activeColor,
                              child: Icon(
                                FontAwesomeIcons.minus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (age > 0) {
                                    age--;
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                result = calculatorBMI(weight, height);
                resultDetail = getInterpretation(bmi);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: inActiveColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          color: inActiveColor,
                          height: 200.0,
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Result',
                                style: textStyle1,
                              ),
                              Text(
                                result.toString(),
                                style: textStyle2,
                              ),
                              Text(
                                resultDetail,
                                style: textStyle1,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              });
            },
            child: Container(
              child: Center(
                child: Text(
                  'Calculator',
                  style: textStyle3,
                ),
              ),
              width: double.infinity,
              height: 80.0,
              color: activeColor,
              margin: EdgeInsets.only(top: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
