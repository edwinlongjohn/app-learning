// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bmi_calculator/components/custom_card.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCardComponent(
                    color: Color(0xff1d1e33),
                  ),
                ),
                Expanded(
                  child: CustomCardComponent(
                    color: Color(0xff1d1e33),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomCardComponent(
              color: Color(0xff1d1e33),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCardComponent(
                    color: Color(0xff1d1e33),
                  ),
                ),
                Expanded(
                  child: CustomCardComponent(
                    color: Color(0xff1d1e33),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
