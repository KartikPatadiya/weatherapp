import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '61ee3a7995725bcf3848d1287056bb08';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(
      double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
      '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Check if the response contains weather data
      if (data.containsKey('main') && data.containsKey('weather')) {
        return data;
      } else {
        throw Exception('Invalid weather data');
      }
    } else {
      throw Exception(
          'Failed to load weather data. Status code: ${response.statusCode}');
    }
  }
}
