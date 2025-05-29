import 'dart:ui';

import 'package:flutter/material.dart';

class UIConstants {
  static const WEATHER_API_KEY = "45dab154f4d44297a17194743250105";
  static const Color PRIMARY = Colors.black;
  static const Color SECONDARY = Colors.white;
  static const Color TERTIARY = Color.fromRGBO(0, 16, 40, 1.0);
  static const String BACKGROUND_IMAGE_DAY = "assets/images/day.jpg";
  static const String BACKGROUND_IMAGE_NIGHT = "assets/images/night.jpg";
  static const double TEXT_SIZE = 20;

  static TextStyle TEXT_STYLE(double? fontSize) {
    return TextStyle(
      color: UIConstants.PRIMARY,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }
  static TextStyle TEXT_STYLE_SECONDARY(double? fontSize) {
    return TextStyle(
      color: UIConstants.SECONDARY,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  static BoxDecoration BOX_DECORATION = BoxDecoration(
    color: UIConstants.SECONDARY,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(128, 128, 128, 0.2),
        spreadRadius: 2,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  );
}

class EmojiConstants {
  static const String CLOUDY = "☁️";
  static const String SUNNY = "☀️";
  static const String SUNNY_CLOUDY = "🌤️";
  static const String RAINY = "🌧️";
  static const String THUNDER = "⛈️";
  static const String NIGHT = "🌙";
  static const String SNOW = "❄️";
}
