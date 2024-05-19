import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  //change this into a const constructure function
  const AnswerButton({
    super.key,
    //By default the named arguments are optional
    // Convert these two positional named arguments by adding required keyword
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          //add padding
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
          //add background color
          backgroundColor: Color.fromARGB(255, 166, 3, 207),
          //add foreground color for text color
          foregroundColor: Colors.white,
          //add shape to decorate button
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      //child: const Text('Answer 1'),
      //TODO: add a Text for answer
      child: Text(
        answerText,
        //TODO: 73. 將Answer button的文字內容居中對齊
        textAlign: TextAlign.center,
      ),
    );
  }
}
