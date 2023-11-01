import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../views/widgets/graphs/point_widget.dart';

class BabyWeightService {
  Future<List<Point>> getReferenceWeight(gender, percentile) async {
    //send a get request to the API endpoint
    var response = await http.get(Uri.parse(getRoute(
        "babychart/weight/getreference?gender=$gender&percentile=$percentile")));
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

  Future<List<Point>> getBabyWeight(id) async {
    //send a get request to the API endpoint
    var response =
        await http.get(Uri.parse(getRoute("babychart/weight/get?id=$id")));
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

  Future<void> addBabyWeight(id, month, value) async {
    //send a post request to the API endpoint
    var response = await http.post(Uri.parse(getRoute("babychart/weight/add")),
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

  Future<void> editBabyWeight(id, month, value) async {
    //send a post request to the API endpoint
    var response = await http.post(Uri.parse(getRoute("babychart/weight/edit")),
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

  Future<void> deleteBabyWeight(id, month) async {
    //send a post request to the API endpoint
    var response =
        await http.post(Uri.parse(getRoute("babychart/weight/delete")),
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

  Future<double?> getRecentBabyWeight(id) async {
    // Send a get request to the API endpoint
    var response =
        await http.get(Uri.parse(getRoute("babychart/weight/get?id=$id")));

    // Check the status code of the response
    if (response.statusCode == 200) {
      // Read the body and filter out points with y = -1.0
      final data = jsonDecode(response.body);
      final validWeights = data.where((weight) => weight != -1.0).toList();

      if (validWeights.isNotEmpty) {
        final mostRecentWeight =
            validWeights.last; // Get the most recent non-negative weight
        return mostRecentWeight.toDouble(); // Assuming the weight is a double
      } else {
        return null; // Return null if there are no valid weights
      }
    } else {
      // Handle the error
      throw Exception(jsonDecode(response.body));
    }
  }
}
