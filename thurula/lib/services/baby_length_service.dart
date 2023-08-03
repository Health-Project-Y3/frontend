import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thurula/constants/routes.dart';
import '../views/widgets/graphs/point_widget.dart';

class BabyLengthService {
  Future<List<Point>> getReferenceLength(gender, percentile) async {
    //send a get request to the API endpoint
    var response = await http.get(Uri.parse(getRoute("babychart/length/getreference?gender=$gender&percentile=$percentile")));
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
    var response = await http.get(Uri.parse(getRoute("babychart/length/get?id=$id")));
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
