import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:thurula/constants/routes.dart';
import 'package:thurula/models/eye_check_model.dart';

class EyeCheckupService {
  static Future<EyeCheck?> create_eyecheck(babyId, checkeddate, score) async {
    // create a map of the data to be sent
    String formattedDateTime = checkeddate.toIso8601String();
    Map<String, dynamic> data = {
      'babyId': babyId,
      'checkeddate': formattedDateTime,
      'score': score,
    };

    String body = json.encode(data);
    var response = await http.post(
      Uri.parse(getRoute("eyecheckup")),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 201) {
      return EyeCheck.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 200) {
      return EyeCheck.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 409) {
      throw (Exception(jsonDecode(response.body)));
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception(jsonDecode(response.body)));
    }
  }
}
