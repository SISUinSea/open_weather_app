import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:weather_app/constants/constants.dart';
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
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 6),
        Text(
          state.weather.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
              style: const TextStyle(fontSize: 18.0),
            ),
            SizedBox(width: 10.0),
            Text(
              '(${state.weather.country})',
              style: const TextStyle(fontSize: 18.0),
            )
          ],
        ),
        const SizedBox(height: 60.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showTemperature(state.weather.temp),
              style: const TextStyle(fontSize: 30.0),
            ),
            SizedBox(width: 20.0),
            Column(
              children: [
                Text(
                  showTemperature(state.weather.tempMax),
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  showTemperature(state.weather.tempMin),
                  style: const TextStyle(fontSize: 18.0),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            showIcon(state.weather.icon),
            Expanded(flex: 3, child: formatText(state.weather.description)),
            const Spacer(),
          ],
        )
      ],
    );
  }

  String showTemperature(double temperature) {
    return temperature.toStringAsFixed(2) + '℃';
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 96,
      height: 96,
    );
  }

  Widget formatText(String description) {
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
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
