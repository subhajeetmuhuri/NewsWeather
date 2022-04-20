import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/categories.dart';
import '../../constants/icon_data.dart';
import '../../models/articles_model.dart';
import '../../models/weather_current_model.dart';
import '../../services/articles_service.dart';
import '../../services/location.dart';
import '../../services/weather_current_service.dart';
import '../search/search_article_windows.dart';
import '../search/search_delegate.dart';
import '../snack_bar.dart';
import '../weather/weather.dart';
import 'home_article_list.dart';
import 'home_article_list_windows.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ArticlesApiService _articlesClient = ArticlesApiService();
  final WeatherCurrentApiService _weatherClient = WeatherCurrentApiService();
  final MyLocation _myLocation = MyLocation();
  final TextEditingController _windowsSearchController =
      TextEditingController();

  late Future<WeatherCurrentModel> _getWeather;

  String? _latitude;
  String? _longitude;

  @override
  initState() {
    super.initState();
    _getLocation().then((value) {
      setState(() {
        _latitude = value[0];
        _longitude = value[1];
      });
      _getWeather = _getCurrentWeather();
    });
  }

  @override
  void dispose() {
    _windowsSearchController.dispose();
    super.dispose();
  }

  Future<List> _getLocation() async => await _myLocation.determinePosition();

  Future<WeatherCurrentModel> _getCurrentWeather() async =>
      await _weatherClient.fetchWeather(
        http.Client(),
        _latitude,
        _longitude,
      );

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: categories.keys
                  .map((tabName) => Tab(child: Text(tabName)))
                  .toList(),
            ),
            title: _titleWidget(_windowsSearchController),
            centerTitle: true,
            leading: _leadingWidget(),
            actions: _actionWidgets(),
          ),
          body: SafeArea(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                for (int i = 0; i < categories.length; i++)
                  _newsArticle(
                    categories[categories.keys.elementAt(i)]!,
                    categories.keys.elementAt(i),
                  )
              ],
            ),
          ),
        ),
      );

  List<Widget> _actionWidgets() => <Widget>[
        if (Platform.isWindows)
          const SizedBox(
            width: 15.0,
          ),
        if (_latitude == null && _longitude == null)
          Container()
        else
          _weatherIconNavigate(),
        if (Platform.isWindows)
          const SizedBox(
            width: 10.0,
          ),
        if (_latitude == null && _longitude == null)
          Container()
        else
          _weatherTemperatureNavigate(),
      ];

  Widget _titleWidget(
    TextEditingController windowsSearchController,
  ) {
    if (Platform.isWindows) {
      return Container(
        width: 500.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextField(
          controller: windowsSearchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: SizedBox(
              width: 80.0,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      if (windowsSearchController.text.isNotEmpty) {
                        windowsSearchController.text = '';
                      } else {
                        mySnackBar(context, 'Nothing to clear!');
                      }
                    },
                    tooltip: 'Clear',
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () =>
                        _searchOrSnackBarWindows(windowsSearchController),
                    child: const Tooltip(
                      message: 'Search',
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            hintText: 'Search News',
            contentPadding: const EdgeInsets.all(11.0),
          ),
          onSubmitted: (value) =>
              _searchOrSnackBarWindows(windowsSearchController),
          textInputAction: TextInputAction.search,
        ),
      );
    }
    return const Text('News');
  }

  void _searchOrSnackBarWindows(
    TextEditingController windowsSearchController,
  ) {
    if (windowsSearchController.text.isNotEmpty) {
      _navPushToSearchWindows(
        context,
        windowsSearchController.text,
      );
    } else {
      mySnackBar(context, 'Enter some query to search!');
    }
  }

  Future<dynamic> _navPushToSearchWindows(
    BuildContext context,
    String query,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchArticlesWindows(
            query: query,
          ),
        ),
      );

  Widget? _leadingWidget() {
    if (Platform.isWindows) {
      return null;
    }
    return IconButton(
      onPressed: () => showSearch(
        context: context,
        delegate: MySearchDelegate(),
      ),
      icon: const Icon(Icons.search),
      tooltip: 'Search',
    );
  }

  Widget _weatherTemperatureNavigate() => FutureBuilder<WeatherCurrentModel>(
        future: _getWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final String temp = '${snapshot.data!.main.temp.toInt()}°C';
            return InkWell(
              onTap: () => _navPushToWeather(context, snapshot.data!),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                    left: 8.0,
                  ),
                  child: Tooltip(
                    message: 'Current weather temperature',
                    child: Text(
                      temp,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );

  Widget _weatherIconNavigate() => FutureBuilder<WeatherCurrentModel>(
        future: _getWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return InkWell(
              onTap: () => _navPushToWeather(context, snapshot.data!),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                child: Tooltip(
                  message: 'Current weather condition',
                  child: Icon(
                    IconData(
                      weatherIcons[snapshot.data!.weather[0].icon]!,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );

  Future<dynamic> _navPushToWeather(
    BuildContext context,
    WeatherCurrentModel weatherCurrentModel,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Weather(
            latitude: _latitude!,
            longitude: _longitude!,
            place: weatherCurrentModel.name,
          ),
        ),
      );

  Widget _newsArticle(
    String selectedQuery,
    String selectedCategory,
  ) =>
      FutureBuilder<ArticlesModel>(
        future: _articlesClient.fetchArticles(
          http.Client(),
          selectedQuery,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            if (Platform.isWindows) {
              return HomeArticleListWindows(
                articles: snapshot.data!.articles,
                selectedCategory: selectedCategory,
              );
            }
            return HomeArticleList(
              articles: snapshot.data!.articles,
              selectedCategory: selectedCategory,
            );
          } else {
            return const Center(
              child: Text('An error has occurred!'),
            );
          }
        },
      );
}
