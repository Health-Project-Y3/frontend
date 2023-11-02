import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../views/widgets/graphs/point_widget.dart';
import 'local_service.dart';

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
    String jwt = await LocalService.getCurrentUserToken();
    //send a get request to the API endpoint
    var response = await http.get(
      Uri.parse(getRoute("babychart/length/get?id=$id")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );
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
    String jwt = await LocalService.getCurrentUserToken();
    //send a post request to the API endpoint
    var response = await http.post(Uri.parse(getRoute("babychart/length/add")),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwt'
        },
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
    String jwt = await LocalService.getCurrentUserToken();
    //send a post request to the API endpoint
    var response = await http.post(Uri.parse(getRoute("babychart/length/edit")),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwt'
        },
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
    String jwt = await LocalService.getCurrentUserToken();
    //send a post request to the API endpoint
    var response = await http.post(
        Uri.parse(getRoute("babychart/length/delete")),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $jwt'
        },
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

  Future<double?> getRecentBabyLength(id) async {
    String jwt = await LocalService.getCurrentUserToken();
    // Send a get request to the API endpoint
    var response = await http.get(
      Uri.parse(getRoute("babychart/length/get?id=$id")),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
    );

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
