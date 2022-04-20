import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_weather_app/ui/weather/cards/weather_tomorrow_details_card.dart';
import 'package:news_weather_app/ui/weather/cards/weather_tomorrow_main_card.dart';

import '../../../models/weather_onecall_model.dart';
import '../../../utils.dart';
import '../cards/weather_forecast_card.dart';

class WeatherTomorrowTab extends StatelessWidget {
  const WeatherTomorrowTab({
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
  Widget build(BuildContext context) => FutureBuilder<WeatherOneCallModel>(
        future: getWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final int hr = timestampToTimeHrInDay(snapshot.data!.hourly[1].dt);

            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 10.0,
                    top: 10.0,
                  ),
                  child: WeatherTomorrowMainCard(
                    weatherModel: snapshot.data!,
                    place: place,
                  ),
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
                    startIndex: 32 - hr,
                    endIndex: min(
                      32 - hr + 24,
                      snapshot.data!.hourly.length,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 10.0,
                    bottom: 10.0,
                  ),
                  child: WeatherTomorrowDetailsCard(
                    weatherModel: snapshot.data!,
                  ),
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
