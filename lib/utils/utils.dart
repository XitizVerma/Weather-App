import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/dtos/constants/constants.dart';

import '../dtos/response/forecast_data.dart';
import '../dtos/response/weather_data.dart';

class Utils {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String formatDateTime(String dateTimeString) {
    DateTime dt = DateTime.parse(dateTimeString.replaceAll(' ', 'T'));
    return '${DateFormat('MMM d').format(dt)} | ${DateFormat('EEEE').format(dt)} | ${DateFormat('h:mm a').format(dt).toLowerCase()}';
  }

  static bool isDay(int? isDay) {
    return isDay == 1;
  }

  static getHourFromTimeStamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return dateTime.hour;
  }

  static List<ForecastTemperatureData> getForecastData(
    WeatherData weatherData,
    int? count,
  ) {
    if (count == null || count == 0) {
      count = 24;
    }

    List<ForecastTemperatureData> forecastData = [];
    int day = 0, hour = getHourFromTimeStamp(weatherData.location!.localtime);
    forecastData.add(ForecastTemperatureData(
      "Now",
      weatherData.current!.tempC,
      getWeatherEmoji(
        weatherData.current!.isDay,
        weatherData.current!.condition.text,
      ),
    ));
    for (int i = 1; i < count; i++) {
      if (hour == 23) {
        day++;
        hour = 0;
      } else {
        hour++;
      }

      List<Hour> hoursData = weatherData.forecast!.forecastday[day].hour;
      Hour hourData = hoursData[0];
      for (Hour h in hoursData) {
        if (hour == getHourFromTimeStamp(h.time)) {
          hourData = h;
          break;
        }
      }

      forecastData.add(ForecastTemperatureData(
        "$hour:00",
        hourData.tempC,
        getWeatherEmoji(hourData.isDay, hourData.condition.text),
      ));
    }

    return forecastData;
  }

  static getWeatherEmoji(int isDay, String condition) {
    if (isDay == 0) {
      return EmojiConstants.NIGHT;
    }
    condition = condition.toLowerCase();
    if (condition.contains("cloud")) {
      return EmojiConstants.CLOUDY;
    }
    if (condition.contains("overcase")) {
      return EmojiConstants.SUNNY_CLOUDY;
    } else if (condition.contains("rain")) {
      return EmojiConstants.RAINY;
    } else if (condition.contains("snow") || condition.contains("blizzard") || condition.contains("sleet") || condition.contains("ice")) {
      return EmojiConstants.SNOW;
    } else {
      return EmojiConstants.SUNNY;
    }
  }

  static double getSunriseProgress(Astro astro, String currTime) {
    DateTime now = DateTime.parse(currTime);

    // Convert "6:15 AM" format to DateTime (assuming same date as now)
    DateTime sunrise = _parseTime(astro.sunrise, now);
    DateTime sunset = _parseTime(astro.sunset, now);

    if (now.isBefore(sunrise)) {
      return 0.0;
    } else if (now.isAfter(sunset)) {
      return 1.0;
    } else {
      final totalDuration = sunset.difference(sunrise).inSeconds;
      final elapsed = now.difference(sunrise).inSeconds;
      return elapsed / totalDuration;
    }
  }

  static DateTime _parseTime(String time, DateTime base) {
    final parts = time.split(' ');
    final hourMinute = parts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);

    if (parts[1].toLowerCase() == 'pm' && hour != 12) hour += 12;
    if (parts[1].toLowerCase() == 'am' && hour == 12) hour = 0;

    return DateTime(base.year, base.month, base.day, hour, minute);
  }
}
