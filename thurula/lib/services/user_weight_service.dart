import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import '../models/user_weight_model.dart';
import 'local_service.dart';

class UserWeightService {
  static Future<UserWeight?> getUserWeight(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      var response = await http.get(
        Uri.parse(getRoute("weight_tracker/$id")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return UserWeight.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }

  // method to get weight/user/ giving id, start date and end date, start date and end date can be null
  static Future<List<UserWeight>> getUserWeights(
      String id, DateTime? startDate, DateTime? endDate) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      // response if theres start and end date if not null and without start and end date
      http.Response response;
      if (startDate != null && endDate != null) {
        response = await http.get(
          Uri.parse(getRoute(
              "weight_tracker/user/$id?startDate=$startDate&endDate=$endDate")),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt'
          },
        );
      } else {
        response = await http.get(
          Uri.parse(getRoute("weight_tracker/user/$id")),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt'
          },
        );
      }

      // check the status code of the response
      if (response.statusCode == 200) {
        List<UserWeight> weights = [];
        var body = jsonDecode(response.body);
        for (var weight in body) {
          weights.add(UserWeight.fromJson(weight));
        }
        return weights;
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return [];
  }

  static Future<bool> patchUserWeight(
      String id, String key, dynamic value) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.patch(
      Uri.parse(getRoute('weight/$id')),
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

  static Future<UserWeight> createUserWeight(UserWeight uex) async {
    String jwt = await LocalService.getCurrentUserToken();
    String body = json.encode(UserWeight.toJson(uex));
    var response = await http.post(
      Uri.parse(getRoute("weight_tracker")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: body,
    );
    if (response.statusCode == 201) {
      return UserWeight.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to create record"));
    }
  }

  static Future<void> deleteUserWeight(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.delete(
      Uri.parse(getRoute("weight_tracker/$id")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 204) {
      // Deletion was successful
    } else if (response.statusCode == 404) {
      throw Exception("Record not found");
    } else {
      throw Exception("Failed to delete record: ${response.statusCode}");
    }
  }

  static Future<void> updateUserWeight(String id, UserWeight uex) async {
    String jwt = await LocalService.getCurrentUserToken();
    String body = json.encode(UserWeight.toJson(uex));
    var response = await http.put(
      Uri.parse(getRoute("weight_tracker/$id")),
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
