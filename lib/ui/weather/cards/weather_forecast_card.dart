import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/icon_data.dart';
import '../../../models/weather_onecall_model.dart';
import '../../../utils.dart';
import '../../styles.dart';

class WeatherForecastCard extends StatelessWidget {
  const WeatherForecastCard({
    Key? key,
    required this.weatherModel,
    required this.startIndex,
    required this.endIndex,
  }) : super(key: key);

  final WeatherOneCallModel weatherModel;
  final int startIndex;
  final int endIndex;

  @override
  Widget build(BuildContext context) {
    final List<WeatherOneCallModelHourly> weatherHourlyList =
        weatherModel.hourly.sublist(startIndex, endIndex);

    return SizedBox(
      height: 150.0,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
          ),
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: weatherHourlyList.length,
              itemBuilder: (BuildContext context, int index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (index == 0)
                    const SizedBox(
                      width: 25.0,
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${weatherHourlyList[index].temp.toInt()}°',
                        style: customTextStyle,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        IconData(
                          weatherIcons[
                              weatherHourlyList[index].weather[0].icon]!,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage,
                        ),
                        size: 40.0,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        timestampToTimeHr(weatherHourlyList[index].dt),
                        style: customTextStyle,
                      ),
                    ],
                  ),
                  if (index == weatherHourlyList.length - 1)
                    const SizedBox(
                      width: 25.0,
                    )
                  else
                    const SizedBox(
                      width: 20.0,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
