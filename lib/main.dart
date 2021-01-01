import 'dart:math';

import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Msibi Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color primary = Color(0xFF3bd891);
  List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  String userInput = '';
  String userOutput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary.withOpacity(0.9),
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "$userInput",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "$userOutput",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ],
              )),
              Expanded(
                  flex: 2,
                  child: Container(
                      color: primary.withOpacity(0.2),
                      padding: EdgeInsets.all(10.0),
                      child: GridView.builder(
                          itemCount: buttons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return Button(
                              buttonText: buttons[index],
                              color: isOperator(buttons[index]) ? generateColor() : primary.withOpacity(0.8),
                              textColor: Colors.white,
                              buttonClick: () {
                                
                                if (buttons[index] == 'C') {
                                    setState(() {
                                      userInput = '';
                                      userOutput = '';
                                    });
                                    return;
                                  }

                                  if (buttons[index] == '=') {
                                    setState(() {
                                      getResults();
                                    });
                                  }

                                  if (buttons[index] == 'DEL' && userInput.length > 0) {
                                    
                                    setState(() {
                                      userInput = userInput.substring(0, userInput.length - 1);
                                    });
                                  }
                                  if ((buttons[index] != 'C') && (buttons[index] != 'DEL' && (buttons[index] != '='))) {
                                    setState(() {
                                      userInput += buttons[index];
                                    });
                                  }
                              },
                            );
                          })))
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String str) {
    List<String> ops = ['%', '/', '+', '-', '=', 'C', 'DEL', 'x'];

    if (ops.contains(str)) {
      return true;
    }
    
    return false;
  }

  void getResults() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll("x", "*");

    Parser parser = Parser();
    Expression exp = parser.parse(finalUserInput);
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userOutput = eval.toString();

  }

  Color generateColor() {
    List<Color> colors = [
      Color(0xFFe67e22),
      Color(0xFF3498db),
      Color(0xFFf1c40f),
      Color(0xFFe74c3c),
    ];
    Random random = Random();

    return colors[random.nextInt(colors.length)];
  }
}
