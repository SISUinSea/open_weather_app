import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/providers/provider.dart';
import 'package:weather_app/providers/temp_settings/temp_settings_provider.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
              weatherApiServices:
                  WeatherApiServices(httpClient: http.Client())),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(
              weatherRepository: context.read<WeatherRepository>()),
        ),
        ChangeNotifierProvider<TempSettingsProvider>(
            create: (context) => TempSettingsProvider()),
        ChangeNotifierProxyProvider<WeatherProvider, ThemeProvider>(
          create: (context) => ThemeProvider(),
          update: (BuildContext context, WeatherProvider wp,
                  ThemeProvider? themeProvider) =>
              themeProvider!..update(wp),
        )
      ],
      builder: (context, _) => MaterialApp(
        title: 'Weather app',
        theme: context.watch<ThemeProvider>().state.appTheme == AppTheme.light
            ? ThemeData.light()
            : ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
