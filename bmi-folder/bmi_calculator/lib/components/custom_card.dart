// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCardComponent extends StatelessWidget {
  final Color color;
  const CustomCardComponent({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
    );
  }
}
