// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final bool loading;
  final String currency;
  final String coin;
  final String currencyRate;
  const CustomCard({
    super.key,
    required this.loading,
    required this.currency,
    required this.coin,
    required this.currencyRate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: loading
            ? Text(
                '1 $coin = ? $currency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              )
            : Text(
                '1 $coin = $currencyRate $currency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
