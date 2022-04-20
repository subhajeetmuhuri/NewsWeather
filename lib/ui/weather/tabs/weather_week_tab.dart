import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/icon_data.dart';
import '../../../models/weather_onecall_model.dart';
import '../../../utils.dart';

class WeatherWeekTab extends StatelessWidget {
  const WeatherWeekTab({
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
            final List<WeatherOneCallModelDaily> weatherDailyList =
                snapshot.data!.daily.sublist(1);

            return ListView.builder(
              itemCount: weatherDailyList.length,
              itemBuilder: (BuildContext context, int index) {
                final String day = timestampToDay(weatherDailyList[index].dt);
                final String weatherCondition = toBeginningOfSentenceCase(
                    weatherDailyList[index].weather[0].description)!;

                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (index == 0)
                                const Text(
                                  'Tomorrow',
                                  style: TextStyle(fontSize: 20.0),
                                )
                              else
                                Text(
                                  day,
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                weatherCondition,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                ),
                                child: Icon(
                                  IconData(
                                    weatherIcons[weatherDailyList[index]
                                        .weather[0]
                                        .icon]!,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage: CupertinoIcons.iconFontPackage,
                                  ),
                                  size: 40.0,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '${weatherDailyList[index].temp.max.toInt()}°',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '${weatherDailyList[index].temp.min.toInt()}°',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    if (index < weatherDailyList.length - 1) const Divider(),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
}
