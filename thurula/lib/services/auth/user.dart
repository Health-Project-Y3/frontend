import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String username;
  String password;

  User(this.username, this.password);

  Future<bool> login() async {
    // create a map of the data to be sent
    Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };

    // encode the data to JSON format
    String body = json.encode(data);

    try {
      // send a post request to the API endpoint
      var response = await http.post(
        Uri.parse('http://10.0.2.2:5154/api/Auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        // login successful, do something with the response data
        print(response.body);
        return true;
      } else {
        // login failed, handle the error
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      // an exception occurred, handle it
      print(e);
      return false;
    }
  }
}
