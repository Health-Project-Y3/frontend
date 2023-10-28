import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../models/user_drinking_model.dart';

class UserDrinkingService {
  static Future<UserDrinking?> getUserDrinking(String id) async {
    try {
      var response = await http.get(
        Uri.parse(getRoute("drinking_tracker/$id")),
        headers: {'Content-Type': 'application/json'},
      );

      // Check the status code of the response
      if (response.statusCode == 200) {
        return UserDrinking.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body).toString());
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<UserDrinking>> getUserDrinkings(String id, String? startDate, String? endDate) async {
    try {
      // Define the URI based on whether start and end dates are provided
      final Uri uri = startDate != null && endDate != null
          ? Uri.parse(getRoute('drinking_tracker/user/$id?startDate=$startDate&endDate=$endDate'))
          : Uri.parse(getRoute('drinking_tracker/user/$id'));

      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final List<UserDrinking> drinkings = (jsonDecode(response.body) as List)
            .map((json) => UserDrinking.fromJson(json))
            .toList();
        return drinkings;
      } else {
        log(jsonDecode(response.body).toString());
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  static Future<bool> patchUserDrinking(String id, String key, dynamic value) async {
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
      return UserDrinking.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception(jsonDecode(response.body).toString());
    } else {
      throw Exception("Unable to create record");
    }
  }

  static Future<void> deleteUserDrinking(String id) async {
    var response = await http.delete(Uri.parse(getRoute("drinking_tracker/$id")));
    if (response.statusCode == 200) {
      return;
    } else {
      log(jsonDecode(response.body).toString());
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
      throw Exception(jsonDecode(response.body).toString());
    } else {
      throw Exception("Unable to update record");
    }
  }
}
