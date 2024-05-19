//this class is built for contain question blueprint, is not a widget
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;
  //TODO: 72. create a method getShuffledAnswers and copy an existing list
  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
