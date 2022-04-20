import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_weather_app/ui/weather/tabs/weather_today_tab.dart';
import 'package:news_weather_app/ui/weather/tabs/weather_tomorrow_tab.dart';
import 'package:news_weather_app/ui/weather/tabs/weather_week_tab.dart';
import 'package:news_weather_app/ui/weather/tabs/windows/weather_today_tab_windows.dart';
import 'package:news_weather_app/ui/weather/tabs/windows/weather_tomorrow_tab_windows.dart';
import 'package:news_weather_app/ui/weather/tabs/windows/weather_week_tab_windows.dart';

import '../../models/weather_onecall_model.dart';
import '../../services/weather_onecall_service.dart';

class Weather extends StatefulWidget {
  const Weather({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.place,
  }) : super(key: key);

  final String latitude;
  final String longitude;
  final String place;

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final WeatherOneCallApiService _weatherClient = WeatherOneCallApiService();
  late Future<WeatherOneCallModel> _getWeather;
  final List<String> _tabs = ['Today', 'Tomorrow', 'This week'];

  @override
  initState() {
    super.initState();
    _getWeather = _getOneCallWeather();
  }

  Future<WeatherOneCallModel> _getOneCallWeather() async =>
      await _weatherClient.fetchWeather(
        http.Client(),
        widget.latitude,
        widget.longitude,
      );

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Weather'),
            centerTitle: true,
            bottom: TabBar(
              tabs: _tabs
                  .map((tabName) => Tab(
                        child: Text(tabName),
                      ))
                  .toList(),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: _weatherTabs(),
            ),
          ),
        ),
      );

  List<Widget> _weatherTabs() {
    if (Platform.isWindows) {
      return <Widget>[
        WeatherTodayTabWindows(
          latitude: widget.latitude,
          longitude: widget.longitude,
          place: widget.place,
          getWeather: _getWeather,
        ),
        WeatherTomorrowTabWindows(
          latitude: widget.latitude,
          longitude: widget.longitude,
          place: widget.place,
          getWeather: _getWeather,
        ),
        WeatherWeekTabWindows(
          latitude: widget.latitude,
          longitude: widget.longitude,
          place: widget.place,
          getWeather: _getWeather,
        ),
      ];
    }
    return <Widget>[
      WeatherTodayTab(
        latitude: widget.latitude,
        longitude: widget.longitude,
        place: widget.place,
        getWeather: _getWeather,
      ),
      WeatherTomorrowTab(
        latitude: widget.latitude,
        longitude: widget.longitude,
        place: widget.place,
        getWeather: _getWeather,
      ),
      WeatherWeekTab(
        latitude: widget.latitude,
        longitude: widget.longitude,
        place: widget.place,
        getWeather: _getWeather,
      ),
    ];
  }
}
