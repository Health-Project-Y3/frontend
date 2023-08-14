import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../models/checklist_model.dart';

class ChecklistService {
  static Future<Checklists> getChecklist(String id) async {
    var response = await http.get(Uri.parse(getRoute('checklist/{id}')));
    if (response.statusCode == 200) {
      return Checklists.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load checklist');
    }
  }
}
