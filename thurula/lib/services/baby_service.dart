import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import '../models/baby_model.dart';

class BabyService {
  static Future<Baby?> getBaby(String id) async {
    try {
      var response = await http.get(
        Uri.parse(getRoute("baby/$id")),
        headers: {'Content-Type': 'application/json'},
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return Baby.fromJson(jsonDecode(response.body));
      } else {
        log(jsonDecode(response.body));
        throw Exception('Failed to find baby');
      }
    } catch (e) {
      log(e as String);
    }
    return null;
  }

  static Future<bool> patchBaby(String id, String key, dynamic value) async {
    var response = await http.patch(
      Uri.parse(getRoute('Baby/$id')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([
        {"op": "replace", "path": "/$key", "value": value}
      ]),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to patch baby');
    }
  }

  static Future<Baby> createBaby(Baby baby) async {
    String body = json.encode(Baby.toJson(baby));
    var response = await http.post(
      Uri.parse(getRoute("Baby")),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 201) {
      return Baby.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to create Baby"));
    }
  }

  static Future<void> deleteBaby(String id) async {
    var response = await http.delete(Uri.parse(getRoute("baby/$id")));
    if (response.statusCode == 200) {
      return;
    } else {
      log(jsonDecode(response.body));
      throw Exception("Failed to delete question");
    }
  }
}
