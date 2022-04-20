import 'package:intl/intl.dart';

String timestampToTime(int time) => DateFormat.jm()
    .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
    .toLowerCase();

String timestampToTimeHr(int time) => DateFormat.j()
    .format(DateTime.fromMillisecondsSinceEpoch(time * 1000))
    .toLowerCase();

int timestampToTimeHrInDay(int time) => int.parse(
    DateFormat.H().format(DateTime.fromMillisecondsSinceEpoch(time * 1000)));

String timestampToDay(int time) => DateFormat('E, d MMM')
    .format(DateTime.fromMillisecondsSinceEpoch(time * 1000));

String uvRisk(int uvIndex) {
  if (uvIndex >= 0 && uvIndex <= 2) {
    return 'Low';
  } else if (uvIndex >= 3 && uvIndex <= 5) {
    return 'Moderate';
  } else if (uvIndex >= 6 && uvIndex <= 7) {
    return 'High';
  } else if (uvIndex >= 8 && uvIndex <= 10) {
    return 'Very high';
  }
  return 'Extreme';
}
