// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/card_child_content.dart';
import 'package:bmi_calculator/components/custom_card.dart';
import 'package:bmi_calculator/components/icon_button.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/pages/bmi_brain.dart';
import 'package:bmi_calculator/pages/result.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 180;
  int weight = 10;
  int age = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomCardComponent(
                    selectGender: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInActiveCardColor,
                    cardChild: CardChildContent(
                      icon: FontAwesomeIcons.mars,
                      text: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCardComponent(
                    selectGender: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    color: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInActiveCardColor,
                    cardChild: CardChildContent(
                      icon: FontAwesomeIcons.venus,
                      text: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomCardComponent(
                cardPadding: EdgeInsets.all(10),
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: kTextLabelStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$height',
                          style: kNumberStyle,
                        ),
                        Text(
                          'cm',
                          style: kTextLabelStyle,
                        ),
                      ],
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Color(0xFFFFFFFF),
                          inactiveTrackColor: Color(0xff8d8e98),
                          thumbColor: kButtomContainerColor,
                          overlayColor: Color(0x29EB1555),
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 15,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 30,
                          ),
                        ),
                        child: Slider(
                          value: height.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },
                          min: 120.0,
                          max: 400.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomCardComponent(
                    //cardPadding: EdgeInsets.all(),
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: kTextLabelStyle,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$weight',
                              style: kNumberStyle,
                            ),
                            Text(
                              'kg',
                              style: kTextLabelStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RoundIconButton(
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                icon: FontAwesomeIcons.plus,
                              ),
                            ),
                            Expanded(
                              child: RoundIconButton(
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                icon: FontAwesomeIcons.minus,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCardComponent(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: kTextLabelStyle,
                        ),
                        Text(
                          '$age',
                          style: kNumberStyle,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RoundIconButton(
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                icon: FontAwesomeIcons.plus,
                              ),
                            ),
                            Expanded(
                              child: RoundIconButton(
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                icon: FontAwesomeIcons.minus,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BottomButton(
              onTap: () {
                BmiBrain calculator = BmiBrain(
                  height: height,
                  weight: weight,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                            solution: calculator.calculateBmi(),
                            result: calculator.getResult(),
                            interpretation: calculator.getInterpretation(),
                          )),
                );
              },
              text: 'CALCULATE',
            ),
          ],
        ),
      ),
    );
  }
}
