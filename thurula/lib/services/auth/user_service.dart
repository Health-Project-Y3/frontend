import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:thurula/constants/routes.dart';
import 'package:thurula/services/local_service.dart';
import '../../database/local_database.dart';
import '../../models/user_model.dart';

class UsernameTakenException implements Exception {
  final String? message;

  UsernameTakenException({this.message = ""});

  @override
  String toString() {
    return 'Sorry, this username is not available';
  }
}

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
        // login successful
        // save the token in shared preferences
        LocalService.setCurrentUserToken(response.body);
        getByUsername(username).then((value) {
          LocalService.setCurrentUserId(value!.id!);
        });
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

  static Future<User?> register(fname, lname, email, password, username) async {
    // create a map of the data to be sent
    Map<String, dynamic> data = {
      'username': username,
      'password': password,
      'firstName': fname,
      'lastName': lname,
      'email': email,
      'gender': "female",
    };

    String body = json.encode(data);
    var response = await http.post(
      Uri.parse(getRoute("Auth/register")),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      return User.fromJson((jsonDecode(response.body)));
    } else if (response.statusCode == 409) {
      throw UsernameTakenException();
    } else if (response.statusCode == 400) {
      throw (Exception(jsonDecode(response.body)));
    } else {
      throw (Exception("Unable to create User"));
    }
  }

  static Future<User?> getUser(String id) async {
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

  static Future<User?> getByUsername(String username) async {
    try {
      var response = await http.get(
        Uri.parse(getRoute("Auth/username/$username")),
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

  static Future<bool> patchUser(String id, String key, dynamic value) async {
    var response = await http.patch(
      Uri.parse(getRoute('User/$id')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([
        {"op": "replace", "path": "/$key", "value": value}
      ]),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to patch user');
    }
  }

  static Future<void> updateUser(String id, User user) async {
    var response = await http.put(
      Uri.parse(getRoute('User/$id')),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(User.toJson(user)),
    );
    if (response.statusCode == 204) {
      return;
    } else {
      log(response.body);
      throw Exception("Failed to update user");
    }
  }

  static Future<void> addBaby(String userId, String babyId) async {
    try {
      // Fetch the current user data
      User? currentUser = await getUser(userId);

      // Add the new baby ID to the user's list of baby IDs
      if (currentUser?.babyIDs == null) {
        currentUser?.babyIDs = [babyId];
      } else {
        currentUser?.babyIDs!.add(babyId);
      }
      // Update the user with the modified data
      await updateUser(userId, currentUser!);
    } catch (e) {
      throw Exception("Failed to add baby: $e");
    }
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
