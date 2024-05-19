import 'package:flutter/material.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:adv_basics/data/questions.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      // instead SingleChildScrollView
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                Text(((data['question_index'] as int) + 1).toString()),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(data['question'] as String),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(data['user_answer'] as String),
                          Text(data['correct_answer'] as String),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
