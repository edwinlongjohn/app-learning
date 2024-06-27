import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool isAlllowed = true;
    if (permission == LocationPermission.denied) {
      isAlllowed = false;
    }
    return isAlllowed;
  }

  String location = 'Get location';

  Future<void> getCurrentLocation() async {
    final permission = await _checkPermission();
    if (!permission) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        setState(() {
          location = position.toString();
        });
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {
      location = position.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(location),
        ),
      ),
    );
  }
}
