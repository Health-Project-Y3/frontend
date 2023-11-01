import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';

import 'local_service.dart';

class UserBmiService {
  static Future<double?> calculateBmi(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      var response = await http.get(
        Uri.parse(getRoute("bmi/calculate/$id")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        return double.tryParse(response.body);
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to calculate BMI');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }

  static Future<String?> checkBmiRange(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      var response = await http.get(
        Uri.parse(getRoute("bmi/checkrange/$id")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        return response
            .body; // Assuming the response is a string like "low", "average", or "high"
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to check BMI range');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }
}
