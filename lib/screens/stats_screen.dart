import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/dtos/constants/constants.dart';
import 'package:weather_app/dtos/response/forecast_data.dart';
import 'package:weather_app/utils/utils.dart';

import '../dtos/response/weather_data.dart';

class StatsScreen extends StatelessWidget {
  final WeatherData weatherData;

  const StatsScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDay = Utils.isDay(weatherData.current?.isDay);

    List<ForecastTemperatureData> temperatureForecastList =
        Utils.getForecastData(weatherData, 20);
    return Container(
      decoration: BoxDecoration(color: UIConstants.SECONDARY),
      child: Column(
        children: [
          SizedBox(height: 20),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 22), // Smooth and responsive
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(temperatureForecastList.length, (index) {
                return Container(
                  width: 80,
                  margin: EdgeInsets.only(
                    left: 0,
                    right: 22,
                    top: 5,
                    bottom: 10,
                  ), // Add spacing between containers
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
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
                  ),
                  child: Column(
                    children: [
                      Text(
                        temperatureForecastList[index].time ?? '',
                        style: UIConstants.TEXT_STYLE(18),
                      ),
                      Text(
                        temperatureForecastList[index].emoji ?? '',
                        style: UIConstants.TEXT_STYLE(20),
                      ),
                      Text(
                        temperatureForecastList[index].temperature ?? '',
                        style: UIConstants.TEXT_STYLE(18),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: Utils.getScreenWidth(context) * 0.9,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
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
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.thermometer_sun,
                            size: 16,
                            color: Colors.deepOrange,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Temperature Today",
                            style: UIConstants.TEXT_STYLE(14),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Avg Temp : ${weatherData.forecast?.forecastday[0].day.avgtempC}°C",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        "Max Temp : ${weatherData.forecast?.forecastday[0].day.maxtempC} °C",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Min Temp : ${weatherData.forecast?.forecastday[0].day.mintempC} °C",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Utils.getScreenWidth(context) * 0.42,
                padding: EdgeInsets.all(16),
                decoration: UIConstants.BOX_DECORATION,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.wind,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text("Wind", style: UIConstants.TEXT_STYLE(14)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${weatherData.current?.windKph} kmph",
                      style: UIConstants.TEXT_STYLE(20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Direction: ${weatherData.current?.windDir}",
                      style: UIConstants.TEXT_STYLE(15),
                    ),
                  ],
                ),
              ),
              Container(
                width: Utils.getScreenWidth(context) * 0.42,
                padding: EdgeInsets.all(16),
                decoration: UIConstants.BOX_DECORATION,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.cloud,
                          size: 16,
                          color: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 5),
                        Text("Cloud Cover", style: UIConstants.TEXT_STYLE(14)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "${weatherData.current?.cloud} %",
                          style: UIConstants.TEXT_STYLE(20),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "UV Index: ${weatherData.current?.uv} ",
                          style: UIConstants.TEXT_STYLE(15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Utils.getScreenWidth(context) * 0.42,
                padding: EdgeInsets.all(16),
                decoration: UIConstants.BOX_DECORATION,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.gauge,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text("Pressure", style: UIConstants.TEXT_STYLE(14)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${weatherData.current?.pressureMb} mb",
                      style: UIConstants.TEXT_STYLE(20),
                    ),
                  ],
                ),
              ),
              Container(
                width: Utils.getScreenWidth(context) * 0.42,
                padding: EdgeInsets.all(16),
                decoration: UIConstants.BOX_DECORATION,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.cloud_drizzle_fill,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Precipitation",
                          style: UIConstants.TEXT_STYLE(14),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${weatherData.forecast?.forecastday[0].day.totalprecipMm} mm",
                      style: UIConstants.TEXT_STYLE(20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: Utils.getScreenWidth(context) * 0.42,
                padding: EdgeInsets.all(16),
                decoration: UIConstants.BOX_DECORATION,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.drop,
                          size: 16,
                          color: Colors.pinkAccent,
                        ),
                        SizedBox(width: 5),
                        Text("Humidity", style: UIConstants.TEXT_STYLE(14)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${weatherData.current?.humidity} %",
                      style: UIConstants.TEXT_STYLE(20),
                    ),
                  ],
                ),
              ),

              Container(
                width: Utils.getScreenWidth(context) * 0.42,
                padding: EdgeInsets.all(16),
                decoration: UIConstants.BOX_DECORATION,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.eye,
                          size: 16,
                          color: Colors.purple,
                        ),
                        SizedBox(width: 5),
                        Text("Visibility", style: UIConstants.TEXT_STYLE(14)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${weatherData.current?.visKm} km",
                      style: UIConstants.TEXT_STYLE(20),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Container(
            width: Utils.getScreenWidth(context) * 0.9,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
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
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isDay
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.sunset,
                                size: 16,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Sunset is coming soon",
                                style: UIConstants.TEXT_STYLE(14),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Sunset will be at",
                            style: UIConstants.TEXT_STYLE(20),
                          ),
                          Text(
                            "${weatherData.forecast?.forecastday[0].astro.sunset}",
                            style: UIConstants.TEXT_STYLE(20),
                          ),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.sunrise,
                                size: 16,
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Sunrise is coming soon",
                                style: UIConstants.TEXT_STYLE(14),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Sunrise will be at",
                            style: UIConstants.TEXT_STYLE(20),
                          ),
                          Text(
                            "${weatherData.forecast?.forecastday[0].astro.sunrise}",
                            style: UIConstants.TEXT_STYLE(20),
                          ),
                        ],
                      ),
                  SizedBox(width: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        EmojiConstants.SUNNY,
                        style: UIConstants.TEXT_STYLE(50),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
