import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget xylophone({required Color color, required int soundNumber}) {
    return TextButton(
      onPressed: () {
        final assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(
          Audio("assets/audios/note$soundNumber.wav"),
        );
      },
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 80,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          shadowColor: Colors.grey[300],
          elevation: 3,
          title: const Text(
            'Xylophone player',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              xylophone(
                color: Colors.red,
                soundNumber: 1,
              ),
              xylophone(
                color: Colors.blue,
                soundNumber: 2,
              ),
              xylophone(
                color: Colors.green,
                soundNumber: 3,
              ),
              xylophone(
                color: Colors.pink,
                soundNumber: 4,
              ),
              xylophone(
                color: Colors.cyan,
                soundNumber: 5,
              ),
              xylophone(
                color: Colors.amber,
                soundNumber: 6,
              ),
              xylophone(
                color: Colors.purple,
                soundNumber: 7,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
