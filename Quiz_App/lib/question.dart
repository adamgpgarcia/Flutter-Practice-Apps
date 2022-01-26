import 'package:flutter/material.dart';

//Stateless widget displays the question and doesn't hold a state
class Question extends StatelessWidget {
  String questionText;

  //Question constructor
  Question(this.questionText);

  //This build widget displays the question
  @override
  Widget build(BuildContext context) {
    return Container(
      //double.infinity makes container fill entire screen width
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
