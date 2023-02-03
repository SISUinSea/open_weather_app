import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/providers/temp_settings/temp_settings_provider.dart';
import 'package:weather_app/providers/theme/theme_provider.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
import 'package:weather_app/repositories/weather_repository.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<WeatherRepository>(
            create: (context) => WeatherRepository(
                weatherApiServices:
                    WeatherApiServices(httpClient: http.Client())),
          ),
          ChangeNotifierProvider<WeatherProvider>(
            create: (context) => WeatherProvider(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          ChangeNotifierProvider<TempSettingsProvider>(
              create: (context) => TempSettingsProvider()),
          ChangeNotifierProxyProvider<WeatherProvider, ThemeProvider>(
            create: (context) => ThemeProvider(),
            update: (BuildContext context, WeatherProvider weatherProvider,
                    ThemeProvider? themeProvider) =>
                themeProvider!..update(weatherProvider),
          ),
        ],
        builder: (context, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: context.watch<ThemeProvider>().state.appTheme ==
                      AppTheme.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              home: HomePage(),
            ));
  }
}
