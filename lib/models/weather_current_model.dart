class WeatherCurrentModel {
  WeatherCurrentModel({
    required this.weather,
    required this.main,
    required this.name,
  });

  final List<WeatherCurrentModelWeather> weather;
  final WeatherCurrentModelMain main;
  final String name;

  factory WeatherCurrentModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherCurrentModel(
        weather: List<WeatherCurrentModelWeather>.from(
          json['weather'].map(
            (x) => WeatherCurrentModelWeather.fromJson(x),
          ),
        ),
        main: WeatherCurrentModelMain.fromJson(json['main']),
        name: json['name'],
      );
}

class WeatherCurrentModelMain {
  WeatherCurrentModelMain({
    required this.temp,
  });

  final double temp;

  factory WeatherCurrentModelMain.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherCurrentModelMain(
        temp: json['temp'].toDouble(),
      );
}

class WeatherCurrentModelWeather {
  WeatherCurrentModelWeather({
    required this.icon,
  });

  final String icon;

  factory WeatherCurrentModelWeather.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherCurrentModelWeather(
        icon: json['icon'],
      );
}
