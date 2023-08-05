import 'dart:convert';

import '../constants/routes.dart';
import '../models/vaccination_model.dart';
import 'package:http/http.dart' as http;

class VaccinationService {
  static Future<List<Vaccination>> getDueVaccinations(babyId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/due/$babyId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<Vaccination> vaccinations = [];
      var body = jsonDecode(response.body);
      for (var vaccination in body) {
        vaccinations.add(Vaccination.fromJson(vaccination));
      }
      return vaccinations;
    } else {
      throw Exception('Failed to get vaccinations');
    }
  }

  static Future<List<Vaccination>> getCompletedVaccinations(babyId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/completed/$babyId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<Vaccination> vaccinations = [];
      var body = jsonDecode(response.body);
      for (var vaccination in body) {
        vaccinations.add(Vaccination.fromJson(vaccination));
      }
      return vaccinations;
    } else {
      throw Exception('Failed to get vaccinations');
    }
  }

  static Future<void> markCompletedVaccination(babyId, vaccineId) async {
    var response = await http.put(
      Uri.parse(getRoute("vaccines/complete/$babyId/$vaccineId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to mark appointment as completed');
    }
  }

  static Future<void> undoCompletedVaccination(babyId, vaccineId) async {
    var response = await http.put(
      Uri.parse(getRoute("vaccines/undo/$babyId/$vaccineId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to undo appointment');
    }
  }

  static Future<Vaccination> getVaccination(vaccineId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/$vaccineId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Vaccination.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get vaccination');
    }
  }
}
