import 'package:flutter/material.dart';
import 'package:quizz/quizz_page.dart';
import 'package:quizz/theme/custom_colors.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.background,
          body: SingleChildScrollView(
            child: QuizzPage(),
          ),
        ),
      ),
    ),
  );
}
