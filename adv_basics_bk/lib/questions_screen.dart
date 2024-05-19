import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    // TODO: implement createState
    //TODO: 69.How we output the questions of questions.dart in this screen widget?
    //import questions.dart for access questiuon List
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  //TODO: 73. add a variable for count currentQuestion index
  var currentQuestionIndex = 0;

  //TODO: 73. add a method answerQuestion for count index
  void answerQuestion(String selectedAnswer) {
    //TODO 76. add a widget to call onSelectAnser
    widget.onSelectAnswer(selectedAnswer);

    //currentQuestionIndex += 1;
    //TODO: 73. 為了讓此index可以更新, 必須再次呼叫setState來重新設定
    setState(() {
      currentQuestionIndex++; // increments the value by 1
    });
  }

  @override
  Widget build(context) {
    //TODO: 69.access questions list coz we already import question list from questions.dart
    final currentQuestion = questions[currentQuestionIndex];

    // TODO: implement build
    return SizedBox(
      // TODO: select wrap with SizedBox
      width: double.infinity, //TODO: this is special value for width
      //TODO: 71. wrap container for add margin
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //TODO: 71. 將AnswerButton 填充整個列寬
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO: add TextStyle widget and set color as white
            Text(
              //TODO: 69. place question text here
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),

              // style: const TextStyle(
              //   color: Colors.white,
              // ),
              //TODO: 71. 將文字置中對齊
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            //TODO: 70. add Mapping list for iterate every list item

            //TODO: 70. map 會回傳Iterable type的object, 且一次回傳一個 value
            //TODO: 70. 但widget的children 要的是回傳一個AnswerButton widget而不是一個 Iterable type object
            //TODO: 70. 因此這裡我們要做一件事叫做calling spreading, 使用built-in operator ...來將個別的 AnswerButton widget 從List Map中拉取出來
            //TODO: 72. 透過getShuffledAnswers 函數可以取得隨機的列表
            ...currentQuestion.getShuffledAnswers().map((answer) {
              //TODO: 73. onTap 點擊按鈕時觸發 answerQuestion
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            })
            //TODO: 70. 現在可以擺脫hardcode的寫法
            //Reuse AnswerButton of out customized widget
            // AnswerButton(
            //   //TODO: 69. use this square bracket noration to access the first answer, but it's hard code
            //   answerText: currentQuestion.answers[0],
            //   onTap: () {},
            // ),
            // AnswerButton(
            //   answerText: currentQuestion.answers[1],
            //   onTap: () {},
            // ),
            // AnswerButton(
            //   answerText: currentQuestion.answers[2],
            //   onTap: () {},
            // ),
            // AnswerButton(
            //   answerText: currentQuestion.answers[3],
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );

    //return const Text('QuestionsScreen');
  }
}
