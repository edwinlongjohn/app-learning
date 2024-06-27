// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bmi_calculator/components/custom_card.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/components/bottom_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.interpretation,
    required this.solution,
  });
  final String solution;
  final String result;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Your Result',
                style: kResultText,
              ),
            ),
            Expanded(
              flex: 5,
              child: CustomCardComponent(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //explanation text
                    Text(
                      result.toUpperCase(),
                      style: TextStyle(
                        color: Color(0XFF24D876),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    //result text
                    Text(
                      solution,
                      style: kResultNumberText,
                    ),

                    //description text
                    Text(
                      interpretation,
                      textAlign: TextAlign.center,
                      style: kResultBodyText,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BottomButton(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
                text: 'RE-CALCULATE',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
