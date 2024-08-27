import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/message_screen.dart';

class NotificationService {

  // create instance of FirebaseMessaging to use messaging functionality
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  // create instance of FlutterLocalNotificationsPlugin to display notification
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// create a method to requestPermission for notification
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

  // create a method to initialize foreground notification service
  static void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print('Notification title: ${message.notification?.title}');
        print('Notification body: ${message.notification?.body}');
        print('Notification custom data/payload: ${message.data}');
      }
      if(Platform.isAndroid){
        initLocalNotification(context,message);
        showNotification(message);
      }else{
        showNotification(message);
      }

    });
  }

// create a method to handle background message
  static Future<void> setupInteractMessage(BuildContext context)async {

// case 1: When app is killed/ terminated
    RemoteMessage? initialMessage =await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage !=null){
      handleMessage(context, initialMessage);
    }

// case 2 : When app is on background
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      handleMessage(context, message);
    });

  }

  // create a method to get FCM Token
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


// create a method to perform some foreground action like navigation on message receive with the help of onDidReceiveNotificationResponse . This will work only for android
  static void initLocalNotification(BuildContext context,RemoteMessage message) async {
    var androidInitializationSetting = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSetting = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleMessage(context,message);
        // Handle notification tapped logic here
      },
    );
  }

  // create a method to handle a message
  static void handleMessage(BuildContext context, RemoteMessage message){
     if(message.data['type']=='msg'){
       Navigator.push(context, MaterialPageRoute(
           builder: (context)=>MessageScreen( id: message.data['id'].toString(),)));
     }
  }

  // create a method to showNotification with the help of FlutterLocalNotificationsPlugin
  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(), // this channel id is used to send grouped msg to the particular user on the same channel id from backend
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

}
