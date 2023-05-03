part of 'quizz_bloc.dart';

abstract class QuizzEvent extends Equatable {
  const QuizzEvent();

  @override
  List<Object> get props => [];
}

class QuizzEventOnStartPressed extends QuizzEvent {}

class QuizzEventOnAnswerPressed extends QuizzEvent {
  final String chosenAnswer;

  const QuizzEventOnAnswerPressed({required this.chosenAnswer});

  @override
  List<Object> get props => [chosenAnswer];
}
