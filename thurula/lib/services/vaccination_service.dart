import 'dart:convert';

import '../constants/routes.dart';
import '../models/vaccination_model.dart';
import 'package:http/http.dart' as http;

import 'local_service.dart';

class VaccinationService {
  static Future<List<Vaccination>> getDueBabyVaccinations(babyId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute("vaccines/baby/due/$babyId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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

  Future<int?> getFirstDueVaccine(String babyId) async {
    final List<Vaccination> dueVaccinations =
        await getDueBabyVaccinations(babyId);
    if (dueVaccinations.isNotEmpty) {
      final firstDueVaccine = dueVaccinations.first;
      return firstDueVaccine.daysFromBirth;
    } else {
      return null; // Return null if no due vaccinations are found
    }
  }

  static Future<List<Vaccination>> getCompletedBabyVaccinations(babyId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute("vaccines/baby/completed/$babyId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.put(
      Uri.parse(getRoute("vaccines/baby/complete/$babyId/$vaccineId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to mark appointment as completed');
    }
  }

  static Future<void> undoCompletedBabyVaccination(babyId, vaccineId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.put(
      Uri.parse(getRoute("vaccines/baby/undo/$babyId/$vaccineId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to undo appointment');
    }
  }

  static Future<List<Vaccination>> getDueMomVaccinations(userId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute("vaccines/mom/due/$userId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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

  Future<int?> getFirstDueMomVaccine(String userId) async {
    final List<Vaccination> dueVaccinations =
        await getDueMomVaccinations(userId);

    if (dueVaccinations.isNotEmpty) {
      final firstDueVaccine = dueVaccinations.first;
      return firstDueVaccine.daysFromBirth;
    } else {
      return null; // Return null if no due vaccinations are found
    }
  }

  static Future<List<Vaccination>> getCompletedMomVaccinations(userId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute("vaccines/mom/completed/$userId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
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
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.put(
      Uri.parse(getRoute("vaccines/mom/complete/$userId/$vaccineId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to mark appointment as completed');
    }
  }

  static Future<void> undoCompletedMomVaccination(userId, vaccineId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.put(
      Uri.parse(getRoute("vaccines/mom/undo/$userId/$vaccineId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to undo appointment');
    }
  }

  static Future<Vaccination> getVaccination(vaccineId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute("vaccines/$vaccineId")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return Vaccination.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get vaccination');
    }
  }
}
