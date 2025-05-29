import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/dtos/constants/constants.dart';
import 'package:weather_app/screens/about_screen.dart';
import 'package:weather_app/screens/home_screen.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[buildHeader(context), buildMenuItems(context)],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Container(
    color: UIConstants.PRIMARY,
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: Column(
      children: [
        SizedBox(height: 20),
        Text(
          "${EmojiConstants.SUNNY_CLOUDY} Weather App",
          style: TextStyle(
            color: UIConstants.SECONDARY,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 10,
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home", style: UIConstants.TEXT_STYLE(20)),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("About", style: UIConstants.TEXT_STYLE(20)),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AboutScreen()));
          },
        ),
      ],
    ),
  );
}
