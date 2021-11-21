// repository == interface

import 'package:rwcourses/model/course.dart';

abstract class Repository {
  Future<List<Course>> getCourses(int domainFilter);
}
