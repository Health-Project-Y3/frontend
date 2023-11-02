import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import '../models/user_bp_model.dart';
import 'local_service.dart';

class UserBpService {
  static Future<UserBp?> getUserBp(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      var response = await http.get(
        Uri.parse(getRoute("bp_tracker/$id")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return UserBp.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }

  // method to get bpr/user/ giving id, start date and end date, start date and end date can be null
  static Future<List<UserBp>> getUserBps(
      String id, DateTime? startDate, DateTime? endDate) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      // response if theres start and end date if not null and without start and end date
      http.Response response;
      if (startDate != null && endDate != null) {
        response = await http.get(
          Uri.parse(getRoute(
              "bp_tracker/user/$id?startDate=$startDate&endDate=$endDate")),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt'
          },
        );
      } else {
        response = await http.get(
          Uri.parse(getRoute("bp_tracker/user/$id")),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt'
          },
        );
      }

      // check the status code of the response
      if (response.statusCode == 200) {
        List<UserBp> bpRecords = [];
        var body = jsonDecode(response.body);
        for (var bpr in body) {
          bpRecords.add(UserBp.fromJson(bpr));
        }
        return bpRecords;
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return [];
  }

  static Future<bool> patchUserBp(String id, String key, dynamic value) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.patch(
      Uri.parse(getRoute('bp_tracker/$id')),
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

  static Future<UserBp> createUserBp(UserBp uex) async {
    String jwt = await LocalService.getCurrentUserToken();
    String body = json.encode(UserBp.toJson(uex));
    var response = await http.post(
      Uri.parse(getRoute("bp_tracker")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: body,
    );
    if (response.statusCode == 201) {
      return UserBp.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to create record"));
    }
  }

  static Future<void> deleteUserBp(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.delete(
      Uri.parse(getRoute("bp_tracker/$id")),
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

  static Future<void> updateUserBp(String id, UserBp uex) async {
    String jwt = await LocalService.getCurrentUserToken();
    String body = json.encode(UserBp.toJson(uex));
    var response = await http.put(
      Uri.parse(getRoute("bp_tracker/$id")),
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

  static Future<UserBp?> getCurrentUserBp(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    try {
      var response = await http.get(
        Uri.parse(getRoute("bp_tracker/user/$id/current")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return UserBp.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find the record');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }
}
