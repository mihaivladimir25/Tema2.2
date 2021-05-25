import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _numbController = new TextEditingController();
  static Random ran = new Random();
  int randomnr = ran.nextInt(100) + 1;
  String msj = "";

  void guess() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    int guess = int.parse(_numbController.text);

    if (guess > 100 || guess < 1) {
      msj = "Numarul trebuie sa fie >=1 si <=100";
      _numbController.clear();
      return;
    }

    if (guess > randomnr) {
      msj = "Mai mic!";
    } else if (guess < randomnr) {
      msj = "Mai mare!";
    } else if (guess == randomnr) {
      msj = "Ai castigat! Numarul este: $randomnr";
      randomnr = ran.nextInt(100) + 1;
    }
    _numbController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text("Guess my number"),
          ),
        ),
        body: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "I'm thinking of a number between 1 and 100",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 27.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "It's your turn to guess my number!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black,
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Try a number!",
                        style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        controller: _numbController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          guess();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Not far"),
                              content: Text('$msj'),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Try again'))
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Guess",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
