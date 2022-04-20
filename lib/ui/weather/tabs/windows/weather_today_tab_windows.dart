import 'package:flutter/material.dart';
import 'package:news_weather_app/ui/weather/cards/weather_today_details_card.dart';
import 'package:news_weather_app/ui/weather/cards/windows/weather_today_main_card_windows.dart';

import '../../../../../models/weather_onecall_model.dart';
import '../../../../../utils.dart';
import '../../cards/weather_forecast_card.dart';

class WeatherTodayTabWindows extends StatelessWidget {
  const WeatherTodayTabWindows({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.place,
    required this.getWeather,
  }) : super(key: key);

  final String latitude;
  final String longitude;
  final String place;
  final Future<WeatherOneCallModel> getWeather;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return FutureBuilder<WeatherOneCallModel>(
      future: getWeather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final int hr = timestampToTimeHrInDay(snapshot.data!.hourly[1].dt);

          return ListView(
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 5.0,
                      left: 10.0,
                    ),
                    child: SizedBox(
                      width: width / 2 - 15.0,
                      child: WeatherTodayMainCardWindows(
                        weatherModel: snapshot.data!,
                        place: place,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      left: 5.0,
                    ),
                    child: SizedBox(
                      width: width / 2 - 15.0,
                      child: WeatherTodayDetailsCard(
                        weatherModel: snapshot.data!,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                  left: 10.0,
                ),
                child: WeatherForecastCard(
                  weatherModel: snapshot.data!,
                  startIndex: 1,
                  endIndex: 32 - hr,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
