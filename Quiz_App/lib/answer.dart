import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  //These are the var that will be passed to the constructor, set to final because they wont change during runtime.
  final Function selectHandler;
  final String answerText;

  //Answer constructor
  Answer(this.selectHandler, this.answerText);

  //This widget presents a container with a button inside with a text box displaying the answerText var
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}
