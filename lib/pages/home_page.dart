import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
              print('city name: $_city');
              if (_city != null) {
                context.read<WeatherProvider>().fetchWeather(_city!);
              }
            },
          )
        ],
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