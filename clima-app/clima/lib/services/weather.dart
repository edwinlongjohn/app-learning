import 'dart:async';

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

const weatherKey = '1fe539396d120245c7b6e7e169146917';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    if (location.error) {
      String data = location.errorText;
      return data;
    } else {
      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'lat': '${location.longitude}',
        'lon': '${location.latitude}',
        'appid': weatherKey,
        'units': 'metric',
      });
      NetworkHelper network = NetworkHelper(url: url);
      var data = await network.getData();
      return data;
    }
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': cityName,
      'appid': weatherKey,
      'units': 'metric',
    });
    NetworkHelper network = NetworkHelper(url: url);
    var data = await network.getData();
    return data;
  }

  Future<dynamic> getWeatherByCountryCodeAndCityName(
      String countryCode, String cityName) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': "$countryCode,$cityName",
      'appid': weatherKey,
      'units': 'metric',
    });
    NetworkHelper network = NetworkHelper(url: url);
    var data = await network.getData();
    return data;
  }

  Future<dynamic> getWeatherImage(String icon) async {
    Uri url = Uri.https('openweathermap.org', '/img/wn/$icon@2x.png');
    NetworkHelper data = NetworkHelper(url: url);

    var result = await data.getImage();
    return result;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Image getWeatherImageIcon(int condition) {
    if (condition < 300) {
      return Image.asset(
        'images/thunderstorm.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    } else if (condition < 400) {
      return Image.asset(
        'images/rainfall.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    } else if (condition < 600) {
      return Image.asset(
        'images/rain.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    } else if (condition < 700) {
      return Image.asset(
        'images/snow.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    } else if (condition < 800) {
      return Image.asset(
        'images/cloud.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    } else if (condition == 800) {
      return Image.asset(
        'images/sun.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    } else if (condition == 801 && condition < 805) {
      return Image.asset(
        'images/cloud.png',
        fit: BoxFit.fill,
        height: 180,
        width: 250,
      );
    } else {
      return Image.asset(
        'images/sun.png',
        fit: BoxFit.fill,
        height: 200,
        width: 200,
      );
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
