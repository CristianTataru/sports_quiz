part of 'quizz_bloc.dart';

abstract class QuizzState extends Equatable {
  const QuizzState();

  @override
  List<Object> get props => [];
}

class QuizzInitialState extends QuizzState {}

class QuizzQuestionsLoading extends QuizzState {}

class QuizzQuestionsLoaded extends QuizzState {
  final List<Intrebare> questions;
  final String currentQuestionText;
  final int currentQuestionNumber;
  final List<String> currentQuestionsAnswers;
  final int wrongAnswersNumber;
  final int correctAnswersNumber;

  const QuizzQuestionsLoaded({
    required this.questions,
    required this.currentQuestionText,
    required this.currentQuestionNumber,
    required this.currentQuestionsAnswers,
    required this.wrongAnswersNumber,
    required this.correctAnswersNumber,
  });

  @override
  List<Object> get props =>
      [currentQuestionText, currentQuestionNumber, currentQuestionsAnswers, wrongAnswersNumber, correctAnswersNumber];
}

class QuizzGameover extends QuizzState {
  final int correctAnswersNumber;
  final int wrongAnswersNumber;

  const QuizzGameover(this.correctAnswersNumber, this.wrongAnswersNumber);

  @override
  List<Object> get props => [correctAnswersNumber, wrongAnswersNumber];
}
