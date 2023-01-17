import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('About the App'),
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 150),
          child: Text(
            '       Welcome to "Daily Planner"! This app is designed to make your life easier. You can no longer fill your head with your affairs. You just need to open the application and perform a couple of actions. Now all your affairs will be stored in this application.            ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
