import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../models/checklist_model.dart';

class ChecklistService {
  ChecklistService(String s);

  static Future<List<Checklists>> getChecklist(String id) async {
    var response = await http.get(
      Uri.parse(getRoute('checklist/newborns')),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<Checklists> checklists = [];
      var body = jsonDecode(response.body);
      for (var checklist in body) {
        checklists.add(Checklists.fromJson(checklist));
      }
      return checklists;
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future<List<Checklists>> fetchNewborns() async {
    final response = await http.get(Uri.parse(getRoute('checklist/newborns')),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(response.body);
      final i = jsonData.map((item) => Checklists.fromJson(item)).toList();

      for (var checklist in i) {
        print(checklist);
        // checklists.add(Checklists.fromJson(checklist));
      }
      print(i.toList());
      return i.toList();
    } else {
      print("HI");
      print(response.body);

      throw Exception(response.body);
    }
  }

  static Future<List<Checklists>> fetchWeek2() async {
    final response = await http.get(Uri.parse(getRoute('checklist/week2')),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(response.body);
      final i = jsonData.map((item) => Checklists.fromJson(item)).toList();
      return i.toList();
    } else {
      throw Exception(response.body);
    }
  }
}
