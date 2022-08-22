import 'dart:convert';

import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:clima_app/services/networking.dart';

const apiKey = 'bc7cc700f7a52e64dad3e906b8a50ba2';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  void getLocationData() async {
    Location locBrain = Location();
    await locBrain.getCurrentLocation();

    latitude = locBrain.latitude;
    longitude = locBrain.longitude;

    String uri =
        'https://samples.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(uri);

    var weatherData = await networkHelper.getData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
