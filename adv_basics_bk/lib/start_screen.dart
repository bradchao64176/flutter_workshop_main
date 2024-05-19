import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  // TODO: Here we add a named argument called startQuiz which is a Function type and no return value
  //via startQuiz to pass switchScreen function of _QuizState to the StartScreen
  //thia is Dart concept to accetp function as an argument values to other functions
  const StartScreen(this.startQuiz, {super.key});
  //auto set the value we get here for this argument as a value for this variable here
  //thus we can receive this value on this stazrtQuiz argument
  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: Color.fromARGB(150, 255, 255, 255),
          ),
          // Opacity(
          //   opacity: 0.1,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          const SizedBox(height: 80),
          Text(
            'Learn Flutter the fun way',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            // onPressed: () {
            //   //...do something when push button
            //   //TODO: on this outlinedButton to execute startQuiz like a function in this anonymous function
            //   startQuiz();
            // },
            //TODO: onPressed required void Function, thus here we can used startQuiz as value directly, byt this way it's the same as above
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          )
        ],
      ),
    );
  }
}
