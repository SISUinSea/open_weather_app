import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:weather_app/widgets/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  late final WeatherProvider weatherProv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherProv = context.read<WeatherProvider>();
    weatherProv.addListener(_registerListener);
  }

  @override
  void dispose() {
    weatherProv.removeListener(_registerListener);
    super.dispose();
  }

  void _registerListener() {
    final WeatherState ws = context.read<WeatherProvider>().state;

    if (ws.status == WeatherStatus.error) {
      errorDialog(context, ws.error.errMsg);
    }
  }

  Widget _showWeather() {
    final state = context.watch<WeatherProvider>().state;

    if (state.status == WeatherStatus.initial) {
      return Center(
          child: Text(
        'Select a City',
        style: TextStyle(fontSize: 20.0),
      ));
    }
    if (state.status == WeatherStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == WeatherStatus.error && state.weather.name.isEmpty) {
      return Center(
          child: Text(
        'Select a City',
        style: TextStyle(fontSize: 20.0),
      ));
    }
    return Center(
      child: Text(
        state.weather.name,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

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
        body: _showWeather());
  }
}

/**
 * dosen't get shaking when 
 * no, there's no way to avoid shaking.
 * just slow type tempo and type generously 
 * this will make shaking as a small handlable issue
 * perfect but expensive solution is buy another movable, lightweight bluetooth carrier.
*/