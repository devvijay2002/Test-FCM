
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class SendNotificationAPI {
  static Future<void> sendNotification({
    required Map<String, String> data,
    required String title,
    String body = 'You got a notification',
    required String toDeviceToken,
  }) async {
    try {
      var res = await http.post(
          Uri.parse('https://fcm.googleapis.com/v1/projects/test-fcm-a782c/messages:send'),
          body: jsonEncode({
            'notification': {'body': body, 'title': title, 'sound': 'default'},
            'priority': 'high',
            'data': data,
            'to': toDeviceToken,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer YOUR_API_KEY', // Replace with your actual key
          });
      log('Notification Response => ${res.body}');
    } catch (e) {
      log('Something went wrong while sending notification $e');
    }
  }
}