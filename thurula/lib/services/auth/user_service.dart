import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:thurula/constants/routes.dart';
import 'package:thurula/services/local_service.dart';
import '../../database/local_database.dart';
import '../../models/user_model.dart';

class UserService {

  static Future<bool> login(username, password) async {
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
        Uri.parse(getRoute("Auth/login")),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        // login successful, do something with the response data
        print(response.body);
        // save the token in shared preferences
        LocalService.setCurrentUserToken(response.body);
        LocalService.setCurrentUserId("64aa7bcddd01ede8be01ca6c");
        LocalService.setCurrentBabyId("64cd599fc65bbef9519bc04c");
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

  static Future<User?> getUser(String id) async{
    try {
      var response = await http.get(
        Uri.parse(getRoute("user/$id")),
        headers: {'Content-Type': 'application/json'},
      );

      // check the status code of the response
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to find user');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }


  //Local Database
  static Future<void> localInsertUser(User user) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> localUsers() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        username: maps[i]['username'],
        token: maps[i]['token'],
      );
    });
  }

  static Future<void> localUpdateUser(User user) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'username = ?',
      whereArgs: [user.username],
    );
  }

  static Future<void> localDeleteUser(String username) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
  }

}
