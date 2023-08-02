import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../models/naptimes_model.dart';

class NapService {
  Future<NapTimes> getNap(String id) async {
    var response = await http.get(Uri.parse(getRoute('naps/$id')));
    if (response.statusCode == 200) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load nap');
    }
  }

  Future<List<NapTimes>> getBabyNaps(String id) async {
    var response = await http.get(Uri.parse(getRoute('naps/baby/$id')));
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

  Future<NapTimes> createNap(NapTimes nap) async {
    var response = await http.post(
      Uri.parse(getRoute('naps')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(nap),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create nap');
    }
  }

  Future<NapTimes> updateNap(NapTimes nap) async {
    var response = await http.put(
      Uri.parse(getRoute('naps/${nap.id}')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(nap),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update nap');
    }
  }

  Future<void> deleteNap(String id) async {
    var response = await http.delete(Uri.parse(getRoute('naps/$id')));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete nap');
    }
  }

  Future<NapTimes> patchNap(String id, String key, dynamic value) async {
    var response = await http.patch(
      Uri.parse(getRoute('naps/$id')),
      headers: {'Content-Type': 'application/json-patch+json'},
      body: jsonEncode({"path": key, "op": "replace", "value": value}),
    );
    if (response.statusCode == 200) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update nap');
    }
  }

  Future<NapTimes> startNap(String babyId) async {
    var response = await http.post(
      Uri.parse(getRoute('naps/start')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(babyId),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to start nap');
    }
  }

  Future<NapTimes> endNap(String napId) async {
    var response = await http.post(
      Uri.parse(getRoute('naps/end')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(napId),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to end nap');
    }
  }

  Future<NapTimes> rateNap(String napId, int sleepQuality) async {
    var response = await http.post(
      Uri.parse(getRoute('naps/rate')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"napId": napId, "sleepQuality": sleepQuality}),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to rate nap');
    }
  }

  Future<NapTimes> addSleepNotes(String napId, String sleepNotes) async {
    var response = await http.post(
      Uri.parse(getRoute('naps/sleepnotes')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"napId": napId, "sleepNotes": sleepNotes}),
    );
    if (response.statusCode == 201) {
      return NapTimes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add sleep notes');
    }
  }
}
