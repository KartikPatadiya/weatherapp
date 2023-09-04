class Weather {
  final String description;
  final double temperature;

  Weather({required this.description, required this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    return Weather(
      description: weather['description'],
      temperature: main['temp'].toDouble(),
    );
  }
}
