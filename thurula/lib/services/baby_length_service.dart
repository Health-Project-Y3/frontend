import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../views/widgets/graphs/point_widget.dart';

class BabyLengthService {
  Future<List<Point>> getReferenceLength(gender, percentile) async {
    //send a get request to the API endpoint
    var response = await http.get(Uri.parse(getRoute(
        "babychart/length/getreference?gender=$gender&percentile=$percentile")));
    // check the status code of the response
    if (response.statusCode == 200) {
      //read the body and make a list of points
      final data = jsonDecode(response.body);
      List<Point> points = [];
      for (var i = 0; i < data.length; i++) {
        points.add(Point(x: i.toDouble(), y: data[i]));
      }
      return points;
    } else {
      // handle the error
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<List<Point>> getBabyLength(id) async {
    //send a get request to the API endpoint
    var response =
        await http.get(Uri.parse(getRoute("babychart/length/get?id=$id")));
    // check the status code of the response
    if (response.statusCode == 200) {
      //read the body and make a list of points
      final data = jsonDecode(response.body);
      List<Point> points = [];
      for (var i = 0; i < data.length; i++) {
        points.add(Point(x: i.toDouble(), y: data[i]));
      }
      return points;
    } else {
      // handle the error
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<void> addBabyLength(id, month, value) async {
    //send a post request to the API endpoint
    var response = await http.post(Uri.parse(getRoute("babychart/length/add")),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "month": month,
          "value": value,
        }));
    // check the status code of the response
    if (response.statusCode == 204) {
      return;
    } else {
      // handle the error
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<void> editBabyLength(id, month, value) async {
    //send a post request to the API endpoint
    var response = await http.post(Uri.parse(getRoute("babychart/length/edit")),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "month": month,
          "value": value,
        }));
    // check the status code of the response
    if (response.statusCode == 204) {
      //read the body and make a list of points
      return;
    } else {
      // handle the error
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<void> deleteBabyLength(id, month) async {
    //send a post request to the API endpoint
    var response =
        await http.post(Uri.parse(getRoute("babychart/length/delete")),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "id": id,
              "month": month,
            }));
    // check the status code of the response
    if (response.statusCode == 204) {
      //read the body and make a list of points
      return;
    } else {
      // handle the error
      throw Exception(jsonDecode(response.body));
    }
  }
}
