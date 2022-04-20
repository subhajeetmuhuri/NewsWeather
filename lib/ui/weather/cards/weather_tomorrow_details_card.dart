import 'package:flutter/material.dart';

import '../../../models/weather_onecall_model.dart';
import '../../../utils.dart';
import '../../styles.dart';

class WeatherTomorrowDetailsCard extends StatelessWidget {
  const WeatherTomorrowDetailsCard({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherOneCallModel weatherModel;

  @override
  Widget build(BuildContext context) {
    final int uvIndex = weatherModel.daily[1].uvi.toInt();

    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.indigo,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 20.0,
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Humidity',
                  style: customTextStyle,
                ),
                Text(
                  '${weatherModel.daily[1].humidity}%',
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Dew point',
                  style: customTextStyle,
                ),
                Text(
                  '${weatherModel.daily[1].dewPoint.toInt()}°',
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Pressure',
                  style: customTextStyle,
                ),
                Text(
                  '${weatherModel.daily[1].pressure} mBar',
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'UV index',
                  style: customTextStyle,
                ),
                Text(
                  '${uvRisk(uvIndex)}, $uvIndex',
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Chance of rain',
                  style: customTextStyle,
                ),
                Text(
                  '${((weatherModel.daily[1].pop) * 100).toInt()}%',
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Wind Speed',
                  style: customTextStyle,
                ),
                Text(
                  '${(weatherModel.daily[1].windSpeed * 3.6).toInt()} km/h',
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Sunrise',
                  style: customTextStyle,
                ),
                Text(
                  timestampToTime(weatherModel.daily[1].sunrise),
                  style: customTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Sunset',
                  style: customTextStyle,
                ),
                Text(
                  timestampToTime(weatherModel.daily[1].sunset),
                  style: customTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
