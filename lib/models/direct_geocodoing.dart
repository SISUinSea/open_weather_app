import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final String country;
  final double lat;
  final double lon;
  DirectGeocoding({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(
        country: data['country'],
        name: data['name'],
        lat: data['lat'],
        lon: data['lon']);
  }

  @override
  List<Object> get props => [name, country, lat, lon];

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, country: $country, lat: $lat, lon: $lon)';
  }
}
