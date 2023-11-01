import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../models/naptimes_model.dart';
import 'local_service.dart';

class NapService {
  static Future<NapTimes> getNap(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute('naps/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load nap');
    }
  }

  ///Get all naps for a given baby [id]
  static Future<List<NapTimes>> getBabyNaps(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.get(
      Uri.parse(getRoute('naps/baby/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode == 200) {
      List<NapTimes> naps = [];
      var body = jsonDecode(response.body);
      for (var nap in body) {
        naps.add(NapTimes.fromJson(nap));
      }
      return naps;
    } else {
      throw Exception('Failed to load naps');
    }
  }

  static Future<NapTimes> createNap(NapTimes nap) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.post(
      Uri.parse(getRoute('naps')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(NapTimes.toJson(nap)),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to create nap');
    }
  }

  ///Replace the entire nap that shares the same id as the nap passed in
  static Future<NapTimes> updateNap(NapTimes nap) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.put(
      Uri.parse(getRoute('naps')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(NapTimes.toJson(nap)),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update nap');
    }
  }

  static Future<void> deleteNap(String id) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.delete(
      Uri.parse(getRoute('naps/$id')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete nap');
    }
  }

  /// Edit only one field of the nap [key] with [value] eg. id="64a9cb10ec5c9834ff73fc36"  key = 'sleepNotes', value = 'Nap was good'
  static Future<NapTimes> patchNap(String id, String key, dynamic value) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.patch(
      Uri.parse(getRoute('naps/$id')),
      headers: {
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode([
        {"path": key, "op": "replace", "value": value}
      ]),
    );
    if (response.statusCode == 200) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update nap');
    }
  }

  static Future<NapTimes> startNap(String babyId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.post(
      Uri.parse(getRoute('naps/startnap')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(babyId),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to start nap');
    }
  }

  static Future<NapTimes> endNap(String napId) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.post(
      Uri.parse(getRoute('naps/endnap')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(napId),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to end nap');
    }
  }

  static Future<NapTimes> rateNap(String napId, int sleepQuality) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.post(
      Uri.parse(getRoute('naps/ratenap')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode({"id": napId, "sleepQuality": sleepQuality}),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to rate nap');
    }
  }

  static Future<NapTimes> addSleepNotes(String napId, String sleepNotes) async {
    String jwt = await LocalService.getCurrentUserToken();
    var response = await http.post(
      Uri.parse(getRoute('naps/sleepnotes')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode({"id": napId, "sleepNotes": sleepNotes}),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add sleep notes');
    }
  }
}
