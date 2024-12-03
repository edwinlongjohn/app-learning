// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class City extends StatefulWidget {
  const City(
      {super.key,
      required this.cityName,
      required this.color,
      required this.countryName});
  final String cityName;
  final Color color;
  final String countryName;
  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  String? date;
  void getFormattedDate() {
    DateTime now = DateTime.now();
    date = DateFormat('EEE, MMM d').format(now);
  }

  Image? imageBytes;
  WeatherModel weather = WeatherModel();
  bool isLoading = true;
  int? temperature;
  String? description;



  Future<void> getWeather() async {
    try {
      var data = await weather.getWeatherByCountryCodeAndCityName(
        widget.countryName,
        widget.cityName,
      );
      if (data != null && data != 'error') {
        //print(data);
        double temp = data['main']['temp'];
        temperature = temp.toInt();
        description = data['weather'][0]['description'];
        try {
          var result = weather.getWeatherImageIcon(data['weather'][0]['id']);
          if (mounted) {
            setState(() {
              imageBytes = result;
              isLoading = false;
            });
          }
        } catch (e) {
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getFormattedDate();
    getWeather();
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      widget.cityName,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    //date
                    Text(
                      textAlign: TextAlign.start,
                      widget.countryName,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(date ?? ''),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),

            //temperature and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : imageBytes != null
                          ? imageBytes!
                          : Text("Failed to fetch image"),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${temperature ?? ''}',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                              ),
                            ),
                            WidgetSpan(
                              child: Transform.translate(
                                offset: Offset(0, -45),
                                child: Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        description ?? '',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

           
          ],
        ),
      ),
    );
  }
}
