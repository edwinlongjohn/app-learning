// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants/constants.dart';

class BottomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  const BottomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: kButtomContainerColor,
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        width: double.infinity,
        height: 80.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            text,
            style: TextStyle(
              //fontStyle: FontStyle.normal,
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
