import 'dart:convert';

import 'package:rwcourses/constants.dart';
import 'package:rwcourses/model/course.dart';
import 'package:rwcourses/repository/repository.dart';
import 'package:http/http.dart' as http;

class CourseRepository implements Repository {
  String dataURL =
      "https://api.raywenderlich.com/api/contents?filter[content_type][]=collection";

  @override
  Future<List<Course>> getCourses(int domainFilter) async {
    var result = <Course>[];
    var url = dataURL;

    if (domainFilter != Constants.allFilter) {
      url += "&filter[domain_ids][]=$domainFilter";
    }

    http.Response response = await http.get(url);
    final apiResponse = json.decode(response.body);

    apiResponse["data"].map((json) {
      result.add(Course.fromJson(json));
    }).toList();

    return result;
  }
}
