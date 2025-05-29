import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/dtos/constants/constants.dart';
import 'package:weather_app/screens/navigation_screen.dart';
import 'package:weather_app/utils/utils.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: UIConstants.SECONDARY),
        backgroundColor: UIConstants.PRIMARY,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: Utils.getScreenWidth(context) * 0.25),
            Text(
              "About",
              style: TextStyle(
                color: UIConstants.SECONDARY,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: UIConstants.SECONDARY,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Title Section
                Container(
                  width: Utils.getScreenWidth(context) * 0.9,
                  padding: EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '📱 Weather App',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: UIConstants.PRIMARY,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Stay informed with accurate, real-time weather updates.',
                        style: TextStyle(
                          fontSize: 16,
                          color: UIConstants.PRIMARY,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Features Section
                Container(
                  width: Utils.getScreenWidth(context) * 0.9,
                  padding: EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '✨ Features',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: UIConstants.PRIMARY,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      buildFeatureItem(
                        'Current weather conditions',
                        CupertinoIcons.thermometer,
                      ),
                      buildFeatureItem(
                        '7-day forecasts',
                        CupertinoIcons.calendar,
                      ),
                      buildFeatureItem(
                        'Multiple location support',
                        CupertinoIcons.location,
                      ),
                      buildFeatureItem(
                        'Beautiful, easy-to-use interface',
                        CupertinoIcons.heart_fill,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  width: Utils.getScreenWidth(context) * 0.9,
                  padding: EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.info_circle_fill,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'App Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: UIConstants.PRIMARY,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      buildInfoItem('Version', '1.0.0', CupertinoIcons.tag),
                      SizedBox(height: 12),
                      buildInfoItem(
                        'Developer',
                        'Xitiz Verma',
                        CupertinoIcons.person_fill,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  width: Utils.getScreenWidth(context) * 0.9,
                  padding: EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.mail_solid,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Contact',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: UIConstants.PRIMARY,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          buildInfoItem(
                            'xitizverma@gmail.com',
                            '',
                            CupertinoIcons.envelope,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFeatureItem(String feature, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: UIConstants.PRIMARY),
          SizedBox(width: 8),
          Text(
            '- $feature',
            style: TextStyle(
              fontSize: 15,
              color: UIConstants.PRIMARY,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: UIConstants.PRIMARY),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 15,
            color: UIConstants.PRIMARY,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            color: UIConstants.PRIMARY,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
