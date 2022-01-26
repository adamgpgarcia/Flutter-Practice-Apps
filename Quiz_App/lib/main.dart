import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() {
  //run app is a function from material.dart that takes a input, runapp calls build method
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //Stateful widget class is from material.dart package
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  //list of question objects for the quiz
  var _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answer': [
        {'text': 'Black', 'score': 10},
        {'text': 'Blue', 'score': 5},
        {'text': 'White', 'score': 9},
        {'text': 'Green', 'score': 2},
      ],
    },
    {
      'questionText': 'What\'s your favorite vacation spot?',
      'answer': [
        {'text': 'The Mountains', 'score': 8},
        {'text': 'The Beach', 'score': 2},
        {'text': 'The City', 'score': 9},
        {'text': 'Vegas!', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite day?',
      'answer': [
        {'text': 'Everyday', 'score': 5},
        {'text': 'Friday', 'score': 1},
        {'text': 'Saturday', 'score': 1},
        {'text': 'Monday', 'score': 10},
      ],
    },
  ];

  var _questionIndex = 0; //class wide variable
  var _totalScore = 0;

  void answerQuestion(int score) {
    _totalScore = _totalScore + score; // += supported
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  void _restQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  Widget build(BuildContext context) {
    //build object is a special object type, build is a method that returns a widget,

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions)
            : Result(_totalScore, _restQuiz),
      ),
    ); //Type widget that returns a widget, materialapp is a class, text() is a widget, home is core widget
  }
}
