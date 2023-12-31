import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import '../models/user_exercise_model.dart';
import 'local_service.dart';

class UserExerciseService {
  static Future<UserExercise?> getUserExercise(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      var response = await http.get(
        Uri.parse(getRoute("exercise/$id")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
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

  // method to get exercise/user/ giving id, start date and end date, start date and end date can be null
  static Future<List<UserExercise>> getUserExercises(
      String id, DateTime? startDate, DateTime? endDate) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      // response if theres start and end date if not null and without start and end date
      http.Response response;
      var startDatestr = startDate?.toIso8601String();
      var endDatestr = endDate?.toIso8601String();
      if (startDate != null && endDate != null) {
        response = await http.get(
          Uri.parse(getRoute(
              "exercise/user/$id?startDate=$startDatestr&endDate=$endDatestr")),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt'
          },
        );
      } else {
        response = await http.get(
          Uri.parse(getRoute("exercise/user/$id")),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt'
          },
        );
      }

      // check the status code of the response
      if (response.statusCode == 200) {
        List<UserExercise> exercises = [];
        var body = jsonDecode(response.body);
        for (var exercise in body) {
          exercises.add(UserExercise.fromJson(exercise));
        }
        return exercises;
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<bool> patchUserExercise(
      String id, String key, dynamic value) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.patch(
      Uri.parse(getRoute('exercise/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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
    String jwt = await LocalService.getCurrentUserToken();
    String body = json.encode(UserExercise.toJson(uex));
    var response = await http.post(
      Uri.parse(getRoute("exercise")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.delete(
      Uri.parse(getRoute("exercise/$id")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      log(jsonDecode(response.body));
      throw Exception("Failed to delete record");
    }
  }

  static Future<void> updateUserExercise(String id, UserExercise uex) async {
    String jwt = await LocalService.getCurrentUserToken();
    String body = json.encode(UserExercise.toJson(uex));
    var response = await http.put(
      Uri.parse(getRoute("exercise/$id")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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
