import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification/local_notification.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalNotificationService notificationService = LocalNotificationService();

  @override
  void initState() {
    super.initState();
    getUserDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      if (message.notification != null) {
        log('Message Title: ${message.notification!.title}');
        log('Message Body: ${message.notification!.body}');
        await notificationService.instantNotification(
          title: message.notification!.title ?? 'Notification Title',
          body: message.notification!.body ?? 'Notification Body',
        );
      }

      // Handle data payload when app is in the background or terminated
      if (message.data.isNotEmpty) {
        log('Message Data: ${message.data}');
        // Access data fields directly as needed, e.g., message.data['key']
      }
    });
  }

  Future<void> getUserDeviceToken() async {
    try {
      var token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        log('Token : $token');
      }
    } catch (e) {
      log('Error in getting token error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                notificationService.instantNotification(
                  title: 'Instant Notification',
                  body: 'This is a test notification',
                );
              },
              child: const Text('Show Instant Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
