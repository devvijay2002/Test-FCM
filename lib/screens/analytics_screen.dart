
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class FirebaseAnalyticsScreen extends StatefulWidget {
  const FirebaseAnalyticsScreen({super.key});

  @override
  State<FirebaseAnalyticsScreen> createState() => _FirebaseAnalyticsScreenState();
}

class _FirebaseAnalyticsScreenState extends State<FirebaseAnalyticsScreen> {
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

@override
  void initState() {
  analytics.setAnalyticsCollectionEnabled(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Firebase Analytics")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async{
                await analytics.logEvent(
                name: "button_tracked",
                parameters: {
                  "button_name": "button1",
                },

              );
                },
              child: const Text("Button 1"),
            ),
            ElevatedButton(
              onPressed: () async{
                await analytics.logEvent(
                  name: "button_tracked",
                  parameters: {
                    "button_name": "button2",
                  },
                );
              },
              child: const Text("Button 2"),
            ),
            ElevatedButton(
              onPressed: () async{
                await analytics.logEvent(
                  name: "button_tracked",
                  parameters: {
                    "button_name": "button3",
                  },
                );
              },
              child: const Text("Button 3"),
            ),
            ElevatedButton(
              onPressed: () async{
                await analytics.logEvent(
                  name: "button_tracked",
                  parameters: {
                    "button_name": "button4",
                  },
                );
              },
              child: const Text("Button 4"),
            ),
          ],
        ),
      ),
    );
  }
}
