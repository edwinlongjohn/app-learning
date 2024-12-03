// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:clima/city_weathers/city.dart';
import 'package:audioplayers/audioplayers.dart';

class CityWeathers extends StatefulWidget {
  const CityWeathers({super.key});

  @override
  State<CityWeathers> createState() => _CityWeathersState();
}

class _CityWeathersState extends State<CityWeathers>
    with SingleTickerProviderStateMixin {
  //local state variables
  final AudioPlayer audio = AudioPlayer();
  bool isPlaying = false;
  final PageController _controller = PageController();
  String? music;

  //animation variables
  late AnimationController _animationController;
  late Animation<double> _animationRotation;
  late Animation<double> _animationRadius;

  //play music
  void play() async {
    await audio.play(AssetSource(music ?? 'ambience.mp3'));
    setState(() {
      isPlaying = true;
    });
  }

  //pause music
  void pause() async {
    await audio.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    //change rotation
    _animationRotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    //change radius
    _animationRadius = Tween(begin: 50.0, end: 10.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    //make animation go back and forth
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isPlaying
          ? FloatingActionButton(
              onPressed: pause,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              child: Icon(
                Icons.pause_circle,
                size: 70,
              ),
            )
          : FloatingActionButton(
              onPressed: play,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              child: Icon(
                Icons.play_circle,
                size: 70,
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.black87,
        child: Row(
          children: [
            PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                offset: Offset(10, -150),
                icon: Icon(Icons.settings),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        mouseCursor: MouseCursor.defer,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        value: 'ambience.mp3',
                        child: Text(
                          'Ambience',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        value: 'heavy-rain.mp3',
                        child: Text(
                          'Rainfall',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        value: 'weather-heavy-rain.mp3',
                        child: Text(
                          'Heavy Rainfall',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        value: 'rain-weather-lightning-thunder.mp3',
                        child: Text(
                          'Weather Combo',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                onSelected: (String newValue) async {
                  setState(() {
                    music = newValue;
                  });
                  await audio.play(AssetSource(music!));

                  setState(() {
                    isPlaying = true;
                  });
                }),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 7,
                      effect: ExpandingDotsEffect(
                        radius: 50.0,
                        dotWidth: 50.0,
                        dotHeight: 3.0,
                        expansionFactor: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: _controller,
                    children: const [
                      City(
                        cityName: "London,",
                        color: Color.fromARGB(255, 51, 28, 202),
                        countryName: 'Uk',
                      ),
                      City(
                        cityName: "Stockholm,",
                        color: Color.fromARGB(255, 11, 53, 192),
                        countryName: 'Sweden',
                      ),
                      City(
                        cityName: "Dhaka,",
                        color: Color.fromARGB(255, 17, 114, 224),
                        countryName: 'Rampura',
                      ),
                      City(
                        cityName: "China,",
                        color: Color.fromARGB(255, 11, 100, 202),
                        countryName: 'Beijing',
                      ),
                      City(
                        cityName: "Russia,",
                        color: Color.fromARGB(255, 11, 83, 165),
                        countryName: 'Moscow',
                      ),
                      City(
                        cityName: "United States,",
                        color: Color.fromARGB(255, 74, 156, 250),
                        countryName: 'California',
                      ),
                      City(
                        cityName: "Nigeria,",
                        color: Color.fromARGB(255, 13, 170, 13),
                        countryName: 'Lagos',
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: _animationRotation.value,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF).withOpacity(.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_animationRadius.value),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFFFFFFF).withOpacity(.2),
                                    offset: const Offset(6.0, 6.0),
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 95, 95, 95)
                                        .withOpacity(.1)
                                        .withOpacity(0.8),
                                    offset: const Offset(-6.0, -6.0),
                                  )
                                ]),
                          ),
                        ),
                        Transform.rotate(
                          angle: _animationRotation.value + 0.2,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Color(0xffF3F0F0).withOpacity(.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_animationRadius.value),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 27, 27, 27)
                                        .withOpacity(0.2),
                                    offset: Offset(-6.0, -6.0),
                                  ),
                                  BoxShadow(
                                    color: Color(0xffF3F0F0).withOpacity(.4),
                                    offset: Offset(6.0, 6.0),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 10,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: _animationRotation.value,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF).withOpacity(.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_animationRadius.value),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFFFFFFF).withOpacity(.2),
                                    offset: const Offset(6.0, 6.0),
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 95, 95, 95)
                                        .withOpacity(.1)
                                        .withOpacity(0.8),
                                    offset: const Offset(-6.0, -6.0),
                                  )
                                ]),
                          ),
                        ),
                        Transform.rotate(
                          angle: _animationRotation.value + 0.2,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Color(0xffF3F0F0).withOpacity(.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_animationRadius.value),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 27, 27, 27)
                                        .withOpacity(0.2),
                                    offset: Offset(-6.0, -6.0),
                                  ),
                                  BoxShadow(
                                    color: Color(0xffF3F0F0).withOpacity(.4),
                                    offset: Offset(6.0, 6.0),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
