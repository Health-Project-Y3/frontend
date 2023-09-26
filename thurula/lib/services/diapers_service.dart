import '../constants/routes.dart';
import '../models/diapertimes_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiaperService {
  static Future<DiaperTimes> getDiaper(String diaperId) async {
    var response = await http.get(
      Uri.parse(getRoute('diapers/$diaperId')),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return DiaperTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get diaper');
    }
  }

  static Future<List<DiaperTimes>> getBabyDiapers(String babyId) async {
    var response = await http.get(
      Uri.parse(getRoute('diapers/baby/$babyId')),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<DiaperTimes> diapers = [];
      var body = jsonDecode(response.body);
      for (var diaper in body) {
        diapers.add(DiaperTimes.fromJson(diaper));
      }
      return diapers;
    } else {
      throw Exception('Failed to get diapers');
    }
  }

  static Future<DiaperTimes> createDiaper(DiaperTimes diaper) async {
    var response = await http.post(
      Uri.parse(getRoute('diapers')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(DiaperTimes.toJson(diaper)),
    );
    if (response.statusCode == 201) {
      return DiaperTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create diaper');
    }
  }



  static Future<void> deleteDiaper(String id) async {
    var response = await http.delete(
      Uri.parse(getRoute('diapers/$id')),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete diaper');
    }
  }

  static Future<DiaperTimes> updateDiaper(String id,DiaperTimes diaper) async {
    var response = await http.put(
      Uri.parse(getRoute('diapers/$id')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(DiaperTimes.toJson(diaper)),
    );
    if (response.statusCode == 201) {
      return DiaperTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update diaper');
    }
  }

  static Future<DiaperTimes> patchDiaper(String id, String key, dynamic value) async {
    var response = await http.patch(
      Uri.parse(getRoute('diapers/$id')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([
        {"op": "replace", "path": "/$key", "value": value}
      ]),
    );
    if (response.statusCode == 200) {
      return DiaperTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to patch diaper');
    }
  }
}

