import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  //List of Maps of (String, Object) objects
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  //Quiz constructor
  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText'],
        ),
        //Using build widget .map the answers and returning the selected answers score and text
        ...(questions[questionIndex]['answer'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
              () => answerQuestion(answer['score']),
              answer[
                  'text']); //passes map to answerQuestion onPress of button video 53 7:00
        }).toList()
      ],
    );
  }
}
