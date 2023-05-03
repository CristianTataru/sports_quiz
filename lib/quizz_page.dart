import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:collection/collection.dart';
import 'package:quizz/bloc/quizz_bloc.dart';
import 'package:quizz/theme/custom_assets.dart';
import 'package:quizz/theme/custom_colors.dart';

final bloc = QuizzBloc();

class QuizzPage extends StatelessWidget {
  const QuizzPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzBloc, QuizzState>(
      bloc: bloc,
      builder: (context, quizzPageState) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sp",
                  style: TextStyle(
                    fontSize: 50,
                    color: CustomColors.customGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SvgPicture.asset(
                  CustomAssets.baseball,
                  width: 35,
                  height: 35,
                  colorFilter: const ColorFilter.mode(CustomColors.customGreen, BlendMode.srcIn),
                ),
                const Text(
                  "rts Quizz",
                  style: TextStyle(
                    fontSize: 50,
                    color: CustomColors.customGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            if (quizzPageState is QuizzInitialState) ...[
              SvgPicture.asset(
                CustomAssets.sports,
                width: 200,
                height: 200,
                colorFilter: const ColorFilter.mode(CustomColors.customGold, BlendMode.srcIn),
              ),
              const SizedBox(height: 30),
              const Text(
                "Let's Play!",
                style: TextStyle(color: Colors.white, fontSize: 45),
              ),
              const SizedBox(height: 32),
              const Text(
                "Play now and test your sports knowledge",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 32)
            ],
            if (quizzPageState is QuizzQuestionsLoaded) ...[
              Text(
                "Question ${quizzPageState.currentQuestionNumber} / 10",
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  quizzPageState.currentQuestionText,
                  style: const TextStyle(fontSize: 35, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25),
              ...quizzPageState.currentQuestionsAnswers.mapIndexed((index, e) => AnswerWidget(index, e)),
              const SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    "Correct answers: ${quizzPageState.wrongAnswersNumber}",
                    style: const TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Wrong answers: ${quizzPageState.correctAnswersNumber}",
                    style: const TextStyle(fontSize: 25, color: Colors.red),
                  )
                ],
              ),
              const SizedBox(height: 8),
              SvgPicture.asset(
                CustomAssets.baseball,
                height: 50,
                width: 50,
                colorFilter: const ColorFilter.mode(CustomColors.customGold, BlendMode.srcIn),
              )
            ],
            if (quizzPageState is QuizzGameover) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Game Over!",
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Text(
                        "Correct answers: ${quizzPageState.correctAnswersNumber}",
                        style: const TextStyle(fontSize: 25, color: Colors.green),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Wrong answers: ${quizzPageState.wrongAnswersNumber}",
                        style: const TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    CustomAssets.sports,
                    width: 200,
                    height: 200,
                    colorFilter: const ColorFilter.mode(CustomColors.customGold, BlendMode.srcIn),
                  ),
                  const SizedBox(height: 32)
                ],
              ),
            ],
            if (quizzPageState is QuizzQuestionsLoading) ...[const CircularProgressIndicator()],
            const SizedBox(height: 30),
            if (quizzPageState is! QuizzQuestionsLoading) ...[
              ElevatedButton(
                onPressed: () {
                  bloc.add(QuizzEventOnStartPressed());
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    backgroundColor: CustomColors.buttonColor,
                    shape: const StadiumBorder(),
                    side: const BorderSide(width: 3, color: Colors.black)),
                child: Text(
                  quizzPageState is! QuizzQuestionsLoaded ? "Play Now" : "Play Again",
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(height: 16)
            ],
            if (quizzPageState is QuizzInitialState) ...[
              const SizedBox(height: 24),
              Image.asset(
                CustomAssets.pitch,
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ],
          ],
        );
      },
    );
  }
}

class AnswerWidget extends StatelessWidget {
  final int index;
  final String answer;
  const AnswerWidget(this.index, this.answer, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.add(QuizzEventOnAnswerPressed(chosenAnswer: answer));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CustomColors.buttonColor,
              border: Border.all(width: 3),
            ),
            child: Text(
              "${index + 1}. $answer",
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
