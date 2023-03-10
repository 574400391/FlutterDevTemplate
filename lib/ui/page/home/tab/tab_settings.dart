import 'package:flutter/material.dart';

class TabSettingsPage extends StatefulWidget {
  const TabSettingsPage({super.key});

  @override
  TabSettingsPageState createState() => TabSettingsPageState();
}

class TabSettingsPageState extends State<TabSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('settings')
            ],
          ),
        ),
      ),
    );
  }
}