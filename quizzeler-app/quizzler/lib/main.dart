// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());
QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoresIcon = [];
  late String msg;
  late Color color;

  int totalQuestion = quizBrain.totalQuestions();
  int questionNo = 1;

  //check
  void check(bool answer) {
    Map totalQuestions = quizBrain.result();
    int qsn = totalQuestions['totalQuestion'];
    int correctAns = totalQuestions['correctAnswers'];
    totalQuestion = totalQuestion;
    //print(quizBrain.questionNo());
    setState(() {
      if (quizBrain.isQuestionComplete()) {
        questionNo = 1;
        if (quizBrain.getAnswer() == answer) {
          quizBrain.addToCorrectAnswer();
          correctAns = correctAns + 1;
        }
        if (correctAns < 5) {
          msg = 'Poor';
          color = Colors.red;
        } else if (correctAns == 5 || correctAns <= 8) {
          msg = 'Good';
          color = Colors.amber;
        } else {
          msg = 'Very Good';
          color = Colors.green;
        }
        Alert(
          context: context,
          type: AlertType.error,
          title: "END OF QUIZ",
          desc:
              "You've reached the end of the quiz your score is: $correctAns/$qsn",
          buttons: [
            DialogButton(
              color: color,
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: Text(
                msg,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ).show();
        //empty list
        scoresIcon.clear();
        //reset correct answer
        quizBrain.resetCorrectAnswer();
      } else {
        questionNo = questionNo + 1;
        if (quizBrain.getAnswer() == answer) {
          quizBrain.addToCorrectAnswer();
          scoresIcon.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          //if answer is wrong
          scoresIcon.add(
            Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          );
        }
      }
      //if answer is correct

      //change question number;
      quizBrain.changeQuestionNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 25.0,
              bottom: 5.0,
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                check(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 25.0,
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                check(false);
              },
            ),
          ),
        ),
        //Add a Row here as your score keeper
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: scoresIcon +
              [
                Text(
                  '[$questionNo/$totalQuestion]',
                  style: TextStyle(color: Colors.white),
                ),
              ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
