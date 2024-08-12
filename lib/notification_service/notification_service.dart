import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initLocalNotification(BuildContext context) async {
    var androidInitializationSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSetting = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tapped logic here
      },
    );
  }
  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  static void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      dev.log("Permission granted");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      dev.log("User granted provisional permission");
    } else {
      dev.log("User denied notification permission");
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  static void firebaseInit() {
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print('Notification title: ${event.notification?.title}');
        print('Notification body: ${event.notification?.body}');
      }
      showNotification(event);
    });
  }

  static Future<String?> getDeviceToken() async {
    try {
      var fcmToken = await messaging.getToken();
      if (fcmToken != null) {
        dev.log('FCM Token: $fcmToken');
        return fcmToken;
      }
    } catch (e) {
      dev.log('Error in getting token: $e');
      return null;
    }
    return null;
  }
}
