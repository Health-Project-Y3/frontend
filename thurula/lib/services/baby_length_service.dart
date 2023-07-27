import 'dart:convert';
import 'package:http/http.dart' as http;
import '../views/widgets/graphs/point_widget.dart';

class BabyLengthService {
  Future<List<Point>> getReferenceLength(gender, percentile) async {
    //send a get request to the API endpoint
    var url =
        "http://10.0.2.2:5154/api/babychart/length/getreference?gender=$gender&percentile=$percentile";
    var response = await http.get(Uri.parse(url));
    // check the status code of the response
    if (response.statusCode == 200) {
      //read the body and make a list of points
      final data = jsonDecode(response.body);
      List<Point> points = [];
      for (var i = 0; i < data.length; i++) {
        points.add(Point(x: i.toDouble(), y: data[i]));
      }
      // print(points);
      return points;
    } else {
      // handle the error
      print(jsonDecode(response.body));
      return [];
    }
  }

  Future<List<Point>> getBabyLength(id) async {
    //send a get request to the API endpoint
    var url =
        "http://api/babychart/length/get?id=$id";
    var response = await http.get(Uri.parse(url));
    // check the status code of the response
    if (response.statusCode == 200) {
      //read the body and make a list of points
      final data = jsonDecode(response.body);
      List<Point> points = [];
      for (var i = 0; i < data.length; i++) {
        points.add(Point(x: i.toDouble(), y: data[i]));
      }
      // print(points);
      return points;
    } else {
      // handle the error
      print(jsonDecode(response.body));
      return [];
    }
  }


}
