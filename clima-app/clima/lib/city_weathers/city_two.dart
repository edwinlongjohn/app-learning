// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CityTwo extends StatelessWidget {
  const CityTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffFEB054),
            Color(0xffFEA14E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Color(0xff6151C3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            '''
              Stockholm,
              Sweden
            ''',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
          //date
          Text(' Tue, Jun 30'),

          //temperature and icon
          Row(
            children: [
              Icon(Icons.abc_sharp),
              Column(children: [
                Text('19 c'),
                Text('rainy'),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
