import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import '../models/user_drinking_model.dart';

class UserDrinkingService {
  static Future<UserDrinking?> getUserDrinking(String id) async {
    try {
      var response = await http.get(
        Uri.parse(getRoute("drinking_tracker/$id")),
        headers: {'Content-Type': 'application/json'},
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return UserDrinking.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }

  // method to get drinking/user/ giving id, start date and end date, start date and end date can be null
  static Future<List<UserDrinking>> getUserDrinkings(
      String id, DateTime? startDate, DateTime? endDate) async {
    try {
      // response if theres start and end date if not null and without start and end date
      http.Response response;
      if (startDate != null && endDate != null) {
        response = await http.get(
          Uri.parse(
              getRoute("drinking/user/$id?startDate=$startDate&endDate=$endDate")),
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        response = await http.get(
          Uri.parse(getRoute("drinking_tracker/user/$id")),
          headers: {'Content-Type': 'application/json'},
        );
      }

      // check the status code of the response
      if (response.statusCode == 200) {
        List<UserDrinking> drinkings = [];
        var body = jsonDecode(response.body);
        for (var drinking in body) {
          drinkings.add(UserDrinking.fromJson(drinking));
        }
        return drinkings;
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return [];
  }

  static Future<bool> patchUserDrinking(
      String id, String key, dynamic value) async {
    var response = await http.patch(
      Uri.parse(getRoute('drinking/$id')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([
        {"op": "replace", "path": "/$key", "value": value}
      ]),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to patch record');
    }
  }

  static Future<UserDrinking> createUserDrinking(UserDrinking uex) async {
    String body = json.encode(UserDrinking.toJson(uex));
    var response = await http.post(
      Uri.parse(getRoute("drinking_tracker")),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 201) {
      return UserDrinking.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to create record"));
    }
  }

  static Future<void> deleteUserDrinking(String id) async {
    var response = await http.delete(Uri.parse(getRoute("drinking_tracker/$id")));
    if (response.statusCode == 200) {
      return;
    } else {
      log(jsonDecode(response.body));
      throw Exception("Failed to delete record");
    }
  }

  static Future<void> updateUserDrinking(String id, UserDrinking uex) async {
    String body = json.encode(UserDrinking.toJson(uex));
    var response = await http.put(
      Uri.parse(getRoute("drinking_tracker/$id")),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 204) {
      return;
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to update record"));
    }
  }
}
