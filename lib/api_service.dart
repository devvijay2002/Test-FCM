import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:test_app/util.dart';

class ApiService{
  static Future<bool> registerOtp() async {
    try {
      final client = await Util.getSSLPinningClient();
      var res = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          'accept':'*/*',
          'Content-Type': 'application/json',
        },
      );

      log("registerOtp ${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      } else {
        log('Request failed with status: ${res.statusCode}');
      }
    } catch (e) {
      log('catch error: $e');
    }

    return false;
  }
}