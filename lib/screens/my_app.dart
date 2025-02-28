
import 'package:flutter/material.dart';
import 'package:test_app/notification_api.dart';
import 'package:test_app/notification_service/notification_service.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
/*    NotificationService.requestNotificationPermission();
    NotificationService.foregroundMessage();
    NotificationService.firebaseInit(context);
    NotificationService.setupInteractMessage(context);
    NotificationService.getDeviceToken();*/
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
              onPressed: ()async{
              await SendNotificationAPI.sendNotification(
                  data: {"type":"msg"},
                  title: "hi",
                  toDeviceToken: "cyqnfIuwQPG9Wm6rdowK6N:APA91bFu0RcLCy8krnimn8BKnnaj0N-grMtT6uTFeumE2qy_dfUK5wmJSPc_SoCBe2c9lRtYB3cgICP65SsItq0DwkpMff1iIVfyjX91qfVPR2_xUBQM4Mj0ASrwktvaRt-iIMmrq3Ff");
              },
              child: const Text('Show Instant Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
