import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import '../models/user_exercise_model.dart';

class UserExerciseService {
  static Future<UserExercise?> getUserExercise(String id) async {
    try {
      var response = await http.get(
        Uri.parse(getRoute("exercise/$id")),
        headers: {'Content-Type': 'application/json'},
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return UserExercise.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }

  static Future<bool> patchUserExercise(
      String id, String key, dynamic value) async {
    var response = await http.patch(
      Uri.parse(getRoute('exercise/$id')),
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

  static Future<UserExercise> createUserExercise(UserExercise uex) async {
    String body = json.encode(UserExercise.toJson(uex));
    var response = await http.post(
      Uri.parse(getRoute("exercise")),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 201) {
      return UserExercise.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to create record"));
    }
  }

  static Future<void> deleteUserExercise(String id) async {
    var response = await http.delete(Uri.parse(getRoute("exercise/$id")));
    if (response.statusCode == 200) {
      return;
    } else {
      log(jsonDecode(response.body));
      throw Exception("Failed to delete record");
    }
  }

  static Future<void> updateUserExercise(String id, UserExercise uex) async {
    String body = json.encode(UserExercise.toJson(uex));
    var response = await http.put(
      Uri.parse(getRoute("exercise/$id")),
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