import 'package:weather_app/exceptions/weather_exception.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/direct_geocodoing.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);
      final Weather weather = tempWeather.copyWith(
          country: directGeocoding.country, name: directGeocoding.name);
      // print(weather);

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
