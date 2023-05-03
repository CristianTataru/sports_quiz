class Intrebare {
  String category;
  String type;
  String question;
  String correctAnswer;
  List<String> wrongAnswers;

  Intrebare(this.category, this.type, this.question, this.correctAnswer, this.wrongAnswers);

  Intrebare.fromJson(Map<String, dynamic> jsonMap)
      : category = jsonMap["category"],
        type = jsonMap['type'],
        question = jsonMap['question'],
        correctAnswer = jsonMap['correct_answer'],
        wrongAnswers = jsonMap['incorrect_answers'].cast<String>();
}
