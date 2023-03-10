import 'package:flutter/material.dart';

class TabDemoPage extends StatefulWidget {
  const TabDemoPage({super.key});

  @override
  TabDemoPageState createState() => TabDemoPageState();
}

class TabDemoPageState extends State<TabDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('demo')
            ],
          ),
        ),
      ),
    );
  }
}