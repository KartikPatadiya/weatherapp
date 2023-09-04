import 'package:flutter/material.dart';
import 'package:weatherapp/API/api.dart';
import 'package:weatherapp/Model/weather_model.dart';
import 'package:weatherapp/screens/location_service.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  late Future<Weather> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = _getLocationWeather();
  }

  Future<Weather> _getLocationWeather() async {
    final position = await _locationService.getLocation();
    final weatherData = await _weatherService.getWeather(
        position!.latitude, position.longitude);
    return Weather.fromJson(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App'),
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _weatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available.');
            } else {
              final weather = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature: ${weather.temperature}°C'),
                  Text('Description: ${weather.description}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
