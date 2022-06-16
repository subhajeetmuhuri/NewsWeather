import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/icon_data.dart';
import '../../../../../models/weather_onecall_model.dart';
import '../../../styles.dart';

class WeatherTomorrowMainCardWindows extends StatelessWidget {
  const WeatherTomorrowMainCardWindows({
    Key? key,
    required this.weatherModel,
    required this.place,
  }) : super(key: key);

  final WeatherOneCallModel weatherModel;
  final String place;

  @override
  Widget build(BuildContext context) => Card(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.location_on_sharp,
                    size: 25.0,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    place,
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22.0,
              ),
              Text(
                'Max ${weatherModel.daily[1].temp.max.toInt()}°',
                style: customTextStyle,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Min ${weatherModel.daily[1].temp.min.toInt()}°',
                style: customTextStyle,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Icon(
                IconData(
                  weatherIcons[weatherModel.daily[1].weather[0].icon]!,
                  fontFamily: CupertinoIcons.iconFont,
                  fontPackage: CupertinoIcons.iconFontPackage,
                ),
                size: 75.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                toBeginningOfSentenceCase(
                    weatherModel.daily[1].weather[0].description)!,
                style: customTextStyle,
              ),
            ],
          ),
        ),
      );
}
