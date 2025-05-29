import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/client/weather_api_client.dart';
import 'package:weather_app/dtos/constants/constants.dart';
import 'package:weather_app/dtos/response/weather_data.dart';
import 'package:weather_app/screens/navigation_screen.dart';
import 'package:weather_app/screens/stats_screen.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/custom_snackbar.dart';

import '../dtos/response/location_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final LocationService locationService = LocationService();

  LocationData locationData = LocationData();
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      await getLocation();

      await getWeatherData();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> getLocation() async {
    final _locationData = await locationService.getLocationData();
    setState(() {
      locationData = _locationData;
    });
  }

  WeatherData weatherData = WeatherData();
  Future<void> getWeatherData() async {
    final _weatherData = await WeatherApiClient.getWeatherData(
      locationData.latitude,
      locationData.longitude,
    );
    setState(() {
      weatherData = _weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
            Text(
              "Fetching Weather Data ...",
              style: UIConstants.TEXT_STYLE(20),
            ),
          ],
        ),
      );
    }
    if (errorMessage != null) {
      return Scaffold(body: Center(child: Text("Error: $errorMessage")));
    }
    bool isDay = true;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: isDay? UIConstants.PRIMARY:UIConstants.SECONDARY),
        backgroundColor: isDay ? UIConstants.SECONDARY : UIConstants.TERTIARY,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${locationData.city}, ${locationData.country}",
              style: TextStyle(
                color: isDay ? UIConstants.PRIMARY : UIConstants.SECONDARY,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              _initializeData();
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar.get(
                  "Refreshed Weather Data!",
                  SnackbarType.SUCCESS,
                  2,
                ),
              );
            },
            icon: Icon(
              Icons.sync_rounded,
              color: isDay ? UIConstants.PRIMARY : UIConstants.SECONDARY,
            ),
          ),
        ],
      ),
      drawer: const CustomNavigationDrawer(),
      backgroundColor: isDay ? UIConstants.SECONDARY : UIConstants.PRIMARY,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    isDay
                        ? UIConstants.BACKGROUND_IMAGE_DAY
                        : UIConstants.BACKGROUND_IMAGE_NIGHT,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 120),
                      Text(
                        "${weatherData.current?.tempC} °C",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w500,
                          color:
                              isDay
                                  ? UIConstants.PRIMARY
                                  : UIConstants.SECONDARY,
                        ),
                      ),
                      Text(
                        "${weatherData.current?.condition.text}",
                        style: TextStyle(
                          fontSize: 28,
                          color:
                              isDay
                                  ? UIConstants.PRIMARY
                                  : UIConstants.SECONDARY,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Feels like ${weatherData.current?.feelslikeC} °C",
                        style: TextStyle(
                          color:
                              isDay
                                  ? UIConstants.PRIMARY
                                  : UIConstants.SECONDARY,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Today",
                            style: TextStyle(
                              color:
                                  isDay
                                      ? UIConstants.PRIMARY
                                      : UIConstants.SECONDARY,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            Utils.formatDateTime(
                              weatherData.location!.localtime,
                            ),
                            style: TextStyle(
                              color:
                                  isDay
                                      ? UIConstants.PRIMARY
                                      : UIConstants.SECONDARY,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StatsScreen(weatherData: weatherData),
          ],
        ),
      ),
    );
  }
}
