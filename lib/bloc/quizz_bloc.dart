import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizz/model/question.dart';
part 'quizz_event.dart';
part 'quizz_state.dart';

class QuizzBloc extends Bloc<QuizzEvent, QuizzState> {
  QuizzBloc() : super(QuizzInitialState()) {
    on<QuizzEventOnStartPressed>(_onQuizzEventOnStartPressed);
    on<QuizzEventOnAnswerPressed>(_onQuizzEventOnAnswerPressed);
  }

  FutureOr<void> _onQuizzEventOnStartPressed(QuizzEventOnStartPressed event, Emitter<QuizzState> emit) async {
    emit(QuizzQuestionsLoading());
    Response response =
        await get(Uri.parse("https://opentdb.com/api.php?amount=10&category=21&difficulty=easy&type=multiple"));

    List<Intrebare> questions =
        (jsonDecode(response.body)['results'] as List).map((e) => Intrebare.fromJson(e)).toList();
    List<String> answers = [...questions[0].wrongAnswers, questions[0].correctAnswer]
        .map((e) => HtmlUnescape().convert(e))
        .toList()
      ..shuffle();

    emit(
      QuizzQuestionsLoaded(
        questions: questions,
        currentQuestionText: HtmlUnescape().convert(questions[0].question),
        currentQuestionNumber: 1,
        currentQuestionsAnswers: answers,
        correctAnswersNumber: 0,
        wrongAnswersNumber: 0,
      ),
    );
  }

  FutureOr<void> _onQuizzEventOnAnswerPressed(QuizzEventOnAnswerPressed event, Emitter<QuizzState> emit) async {
    if (state is! QuizzQuestionsLoaded) {
      return;
    }
    final previousLoadedState = state as QuizzQuestionsLoaded;
    int wrongAnswersNumber = previousLoadedState.wrongAnswersNumber;
    int correctAnswersNumber = previousLoadedState.correctAnswersNumber;
    if (event.chosenAnswer ==
        HtmlUnescape()
            .convert(previousLoadedState.questions[previousLoadedState.currentQuestionNumber - 1].correctAnswer)) {
      wrongAnswersNumber = wrongAnswersNumber + 1;
    } else {
      correctAnswersNumber = correctAnswersNumber + 1;
    }
    if (previousLoadedState.currentQuestionNumber == 10) {
      emit(QuizzGameover(wrongAnswersNumber, correctAnswersNumber));
      return;
    }
    final nextQuestion = previousLoadedState.questions[previousLoadedState.currentQuestionNumber];
    final answers = [...nextQuestion.wrongAnswers, nextQuestion.correctAnswer]
        .map((e) => HtmlUnescape().convert(e))
        .toList()
      ..shuffle();
    emit(
      QuizzQuestionsLoaded(
        currentQuestionText: HtmlUnescape().convert(nextQuestion.question),
        currentQuestionNumber: previousLoadedState.currentQuestionNumber + 1,
        currentQuestionsAnswers: answers,
        wrongAnswersNumber: wrongAnswersNumber,
        correctAnswersNumber: correctAnswersNumber,
        questions: previousLoadedState.questions,
      ),
    );
  }
}
