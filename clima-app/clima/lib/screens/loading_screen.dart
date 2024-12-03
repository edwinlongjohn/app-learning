// ignore_for_file: prefer_const_constructors

import 'package:clima/screens/location_screen.dart';
import 'package:clima/screens/offline.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String locationText = 'Get location';

  Future<void> getLocationData() async {
    try {
      WeatherModel weatherModel = WeatherModel();

      //get weather data
      var decodedData = await weatherModel.getLocationWeather();
      if (decodedData != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(weatherData: decodedData),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Offline(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    //print('$latitude');

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
