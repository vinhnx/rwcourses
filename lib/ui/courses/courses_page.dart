import 'package:flutter/material.dart';
import 'package:rwcourses/constants.dart';
import 'package:rwcourses/model/course.dart';
import 'package:rwcourses/repository/course_repository.dart';
import 'package:rwcourses/ui/course_detail/course_detail_page.dart';
import 'package:rwcourses/ui/courses/courses_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _controller = CoursesController(CourseRepository());
  int _filterValue = Constants.allFilter;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();

    _initPreferences().whenComplete(() {
      _loadValue();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
        future: _controller.fetchCourses(_filterValue),
        builder: (context, snapshot) {
          var courses = snapshot.data;
          if (courses == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return _buildRow(courses[index]);
              });
        });
  }

  Widget _buildRow(Course course) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          title: Text(course.name, style: TextStyle(fontSize: 15.0)),
          subtitle: Text(course.domainsString),
          leading: Hero(
            tag: "cardArtwork-${course.courseId}",
            transitionOnUserGestures: true,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(course.artworkUrl)),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CourseDetailsPage(course: course);
            }));
          }),
    );
  }

  Future<void> _initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  _loadValue() async {
    if (prefs != null) {
      _filterValue = prefs!.getInt(Constants.filterKey);
    }
  }
}
