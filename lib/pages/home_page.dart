import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() {
    WeatherRepository(
            weatherApiServices: WeatherApiServices(httpClient: http.Client()))
        .fetchWeather('london');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: Text('Home1'),
      ),
    );
  }
}

/**
 * dosen't get shaking when 
 * no, there's no way to avoid shaking.
 * just slow type tempo and type generously 
 * this will make shaking as a small handlable issue
 * perfect but expensive solution is buy another movable, lightweight bluetooth carrier.
*/