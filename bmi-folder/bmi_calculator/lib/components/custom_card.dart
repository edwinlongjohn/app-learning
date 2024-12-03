// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCardComponent extends StatelessWidget {
  final Color color;
  final Widget? cardChild;
  final EdgeInsets? cardPadding;
  void Function()? selectGender;
  CustomCardComponent({
    super.key,
    this.cardPadding,
    required this.color,
    this.cardChild,
    this.selectGender,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectGender,
      child: Container(
        padding: cardPadding,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: cardChild,
      ),
    );
  }
}
