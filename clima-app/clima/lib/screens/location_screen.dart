import 'package:clima/screens/cities_weather_screen.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherData});
  final dynamic weatherData;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherDetails = WeatherModel();
  int? temperature;
  String? message;
  String? weatherEmoji;
  String? cityName;

  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherData);
  }

  void updateUi(dynamic data) {
    setState(() {
      if (data == null) {
        temperature = 0;
        message = 'unable to get weather data';
        weatherEmoji = '';
        cityName = '';
        return;
      }
      if (data == 'something went wrong') {
        temperature == 0;
        message = 'error occurred';
        weatherEmoji = 'unable to get weather data';
        cityName = '';
        return;
      }

      double temp = data['main']['temp'];
      temperature = temp.toInt();
      var condition = data['weather'][0]['id'];
      weatherEmoji = weatherDetails.getWeatherIcon(condition);
      message = weatherDetails.getMessage(temp.toInt());
      cityName = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var decodedData =
                          await weatherDetails.getLocationWeather();
                      updateUi(decodedData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityWeathers(),
                        ),
                      );
                    },
                    child: const Text(
                      "More...",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          color: Color.fromARGB(255, 248, 248, 248)),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                      if (city != null) {
                        var decodedData =
                            await weatherDetails.getCityWeather(city);
                        updateUi(decodedData);  
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherEmoji',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
