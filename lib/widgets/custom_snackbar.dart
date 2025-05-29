import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/dtos/constants/constants.dart';

enum SnackbarType { ERROR, INFO, SUCCESS, WARNING, NEUTRAL }

class CustomSnackbar {
  static const Color SUCCESS = Colors.green;
  static const Color INFO = Colors.blue;
  static const Color WARNING = Colors.yellow;
  static const Color ERROR = Colors.red;

  static const String SUCCESS_HEADER = "Success";
  static const String INFO_HEADER = "Info";
  static const String WARNING_HEADER = "Warning";
  static const String ERROR_HEADER = "Error";

  static SnackBar get(String text, SnackbarType type, int durationInSeconds) {
    String headerTitle;
    Color headingColor;
    IconData iconType;
    switch (type) {
      case SnackbarType.SUCCESS:
        headerTitle = SUCCESS_HEADER;
        headingColor = SUCCESS;
        iconType = CupertinoIcons.checkmark_alt_circle_fill;
        break;
      case SnackbarType.ERROR:
        headerTitle = ERROR_HEADER;
        headingColor = ERROR;
        iconType = CupertinoIcons.exclamationmark_triangle_fill;
        break;
      case SnackbarType.INFO:
        headerTitle = INFO_HEADER;
        headingColor = INFO;
        iconType = CupertinoIcons.info_circle_fill;
        break;
      case SnackbarType.WARNING:
        headerTitle = WARNING_HEADER;
        headingColor = WARNING;
        iconType = CupertinoIcons.exclamationmark_circle_fill;
        break;
      default:
        headerTitle = INFO_HEADER;
        headingColor = Colors.white;
        iconType = CupertinoIcons.checkmark_alt_circle_fill;
        break;
    }

    return SnackBar(
      content: Column(
        children: [
          Row(
            children: [
              Icon(iconType, color: headingColor, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  headerTitle,
                  style: TextStyle(color: headingColor, fontSize: 20),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Row(
            children: [
              Text(
                text,
                style: TextStyle(color: UIConstants.PRIMARY, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: UIConstants.SECONDARY,
      duration: Duration(seconds: durationInSeconds),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    );
  }
}
