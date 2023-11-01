import '../constants/routes.dart';
import '../models/feeding_times_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'local_service.dart';

class FeedingService {
  static Future<FeedingTimes> createFeeding(FeedingTimes feeding) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.post(
      Uri.parse(getRoute('feeding')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(FeedingTimes.toJson(feeding)),
    );
    if (response.statusCode == 201) {
      return FeedingTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create feeding');
    }
  }

  static Future<FeedingTimes> getFeeding(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute('feeding/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return FeedingTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get feeding');
    }
  }

  static Future<List<FeedingTimes>> getBabyFeedings(String babyId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute('feeding/baby/$babyId')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      List<FeedingTimes> feedings = [];
      var body = jsonDecode(response.body);
      for (var feeding in body) {
        feedings.add(FeedingTimes.fromJson(feeding));
      }
      return feedings;
    } else {
      throw Exception('Failed to get feedings');
    }
  }

  static Future<void> deleteFeeding(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.delete(
      Uri.parse(getRoute('feeding/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete feeding');
    }
  }

  static Future<void> updateFeeding(String id, FeedingTimes feeding) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.put(
      Uri.parse(getRoute('feeding/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(FeedingTimes.toJson(feeding)),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to update feeding');
    }
  }

  static Future<FeedingTimes> patchFeeding(
      String id, String key, dynamic value) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.patch(
      Uri.parse(getRoute('feeding/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode([
        {"op": "replace", "path": "/$key", "value": value}
      ]),
    );
    if (response.statusCode == 200) {
      return FeedingTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to patch feeding');
    }
  }
}
