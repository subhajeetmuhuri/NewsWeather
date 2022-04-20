class WeatherOneCallModel {
  WeatherOneCallModel({
    required this.current,
    required this.hourly,
    required this.daily,
  });

  final WeatherOneCallModelCurrent current;
  final List<WeatherOneCallModelHourly> hourly;
  final List<WeatherOneCallModelDaily> daily;

  factory WeatherOneCallModel.fromJson(Map<String, dynamic> json) =>
      WeatherOneCallModel(
        current: WeatherOneCallModelCurrent.fromJson(json['current']),
        hourly: List<WeatherOneCallModelHourly>.from(
          json['hourly'].map(
            (x) => WeatherOneCallModelHourly.fromJson(x),
          ),
        ),
        daily: List<WeatherOneCallModelDaily>.from(
          json['daily'].map(
            (x) => WeatherOneCallModelDaily.fromJson(x),
          ),
        ),
      );
}

class WeatherOneCallModelCurrent {
  WeatherOneCallModelCurrent({
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.visibility,
    required this.windSpeed,
    required this.weather,
  });

  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;

  final int visibility;
  final double windSpeed;

  final List<WeatherOneCallModelWeather> weather;

  factory WeatherOneCallModelCurrent.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherOneCallModelCurrent(
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        pressure: json['pressure'],
        humidity: json['humidity'],
        dewPoint: json['dew_point'].toDouble(),
        uvi: json['uvi'].toDouble(),
        visibility: json['visibility'],
        windSpeed: json['wind_speed'].toDouble(),
        weather: List<WeatherOneCallModelWeather>.from(
          json['weather'].map(
            (x) => WeatherOneCallModelWeather.fromJson(x),
          ),
        ),
      );
}

class WeatherOneCallModelWeather {
  WeatherOneCallModelWeather({
    required this.description,
    required this.icon,
  });

  final String description;
  final String icon;

  factory WeatherOneCallModelWeather.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherOneCallModelWeather(
        description: json['description'],
        icon: json['icon'],
      );
}

class WeatherOneCallModelDaily {
  WeatherOneCallModelDaily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.weather,
    required this.pop,
    required this.uvi,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final WeatherOneCallModelTemp temp;

  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final List<WeatherOneCallModelWeather> weather;
  final double pop;
  final double uvi;

  factory WeatherOneCallModelDaily.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherOneCallModelDaily(
        dt: json['dt'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        temp: WeatherOneCallModelTemp.fromJson(json['temp']),
        pressure: json['pressure'],
        humidity: json['humidity'],
        dewPoint: json['dew_point'].toDouble(),
        windSpeed: json['wind_speed'].toDouble(),
        weather: List<WeatherOneCallModelWeather>.from(
          json['weather'].map(
            (x) => WeatherOneCallModelWeather.fromJson(x),
          ),
        ),
        pop: json['pop'].toDouble(),
        uvi: json['uvi'].toDouble(),
      );
}

class WeatherOneCallModelTemp {
  WeatherOneCallModelTemp({
    required this.min,
    required this.max,
  });

  final double min;
  final double max;

  factory WeatherOneCallModelTemp.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherOneCallModelTemp(
        min: json['min'].toDouble(),
        max: json['max'].toDouble(),
      );
}

class WeatherOneCallModelHourly {
  WeatherOneCallModelHourly({
    required this.dt,
    required this.temp,
    required this.weather,
    required this.pop,
  });

  final int dt;
  final double temp;

  final List<WeatherOneCallModelWeather> weather;
  final double pop;

  factory WeatherOneCallModelHourly.fromJson(
    Map<String, dynamic> json,
  ) =>
      WeatherOneCallModelHourly(
        dt: json['dt'],
        temp: json['temp'].toDouble(),
        weather: List<WeatherOneCallModelWeather>.from(
          json['weather'].map(
            (x) => WeatherOneCallModelWeather.fromJson(x),
          ),
        ),
        pop: json['pop'].toDouble(),
      );
}
