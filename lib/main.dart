import 'dart:ui';

import 'package:flutter/material.dart';

import 'ui/home/home.dart';

void main() {
  runApp(const NewsWeatherApp());
}

class NewsWeatherApp extends StatelessWidget {
  const NewsWeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'News & Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const Home(),
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
      );
}
