
import 'package:flutter/material.dart';
import 'package:test_app/notification_service/notification_service.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    NotificationService.requestNotificationPermission();
    NotificationService.firebaseInit();
    NotificationService.getDeviceToken();
   // NotificationService.initLocalNotification(context, null);
    super.initState();
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

              },
              child: const Text('Show Instant Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
