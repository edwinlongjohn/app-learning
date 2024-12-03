// ignore_for_file: prefer_const_constructors

import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.black54),
        ),
         
      ),
      home: Welcome(),
    );
  }
}
