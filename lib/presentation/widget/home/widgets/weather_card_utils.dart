import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

abstract class WeatherCardHelper {
  static String getStateCountryDescription(MalaysianCity city) {
    if (city.capital == 'primary') {
      return "Capital of ${city.country}";
    }
    return "${city.adminName}, ${city.country}";
  }

  static String getTodayDescription({DateTime? dateTime}) {
    final time = dateTime ?? DateTime.now();

    return DateFormat(
            dateTime == null ? 'EEEE ,yyyy-MM-dd' : 'EEEE ,yyyy-MM-dd hh:00a')
        .format(time);
  }
}

extension WeatherExtension on Weather {
  IconData? get getIcon {
    switch (description) {
      case "clear sky":
        return CupertinoIcons.sun_max;
      case "few clouds":
        return CupertinoIcons.cloud_sun;
      case "scattered clouds":
        return CupertinoIcons.cloud_sun;
      case "broken clouds":
        return CupertinoIcons.cloud;
      case "overcast clouds":
        return CupertinoIcons.cloud;
      case "light rain":
        return CupertinoIcons.cloud_rain;
      case "shower rain":
        return CupertinoIcons.cloud_rain;
      case "moderate rain":
        return CupertinoIcons.cloud_rain;
      case "rain":
        return CupertinoIcons.cloud_rain_fill;
      case "thunderstorm":
        return CupertinoIcons.cloud_bolt_rain_fill;
      case "snow":
        return CupertinoIcons.snow;
      case "mist":
        return CupertinoIcons.sun_dust;
      default:
        return null;
    }
  }
}
