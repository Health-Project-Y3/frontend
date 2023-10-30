import 'dart:convert';

import '../constants/routes.dart';
import '../models/vaccination_model.dart';
import 'package:http/http.dart' as http;

class VaccinationService {
  static Future<List<Vaccination>> getDueBabyVaccinations(babyId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/baby/due/$babyId")),
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

  static Future<List<Vaccination>> getCompletedBabyVaccinations(babyId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/baby/completed/$babyId")),
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

  static Future<void> markCompletedBabyVaccination(babyId, vaccineId) async {
    var response = await http.put(
      Uri.parse(getRoute("vaccines/baby/complete/$babyId/$vaccineId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to mark appointment as completed');
    }
  }

  static Future<void> undoCompletedBabyVaccination(babyId, vaccineId) async {
    var response = await http.put(
      Uri.parse(getRoute("vaccines/baby/undo/$babyId/$vaccineId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to undo appointment');
    }
  }

  static Future<List<Vaccination>> getDueMomVaccinations(userId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/mom/due/$userId")),
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

  static Future<List<Vaccination>> getCompletedMomVaccinations(userId) async {
    var response = await http.get(
      Uri.parse(getRoute("vaccines/mom/completed/$userId")),
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

  static Future<void> markCompletedMomVaccination(userId, vaccineId) async {
    var response = await http.put(
      Uri.parse(getRoute("vaccines/mom/complete/$userId/$vaccineId")),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to mark appointment as completed');
    }
  }

  static Future<void> undoCompletedMomVaccination(userId, vaccineId) async {
    var response = await http.put(
      Uri.parse(getRoute("vaccines/mom/undo/$userId/$vaccineId")),
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
