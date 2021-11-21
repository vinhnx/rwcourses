import 'package:flutter/material.dart';
import 'package:rwcourses/model/course.dart';
import 'package:rwcourses/ui/course_detail/image_container.dart';
import 'package:rwcourses/utils/string_extensions.dart';

class CourseDetailsPage extends StatelessWidget {
  final Course course;

  CourseDetailsPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(course.name)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            _buildMain(context),
            _buildDetails(context)
          ],
        ));
  }

  _buildBanner() {
    return Hero(
      tag: "cardArtwork-${course.courseId}",
        transitionOnUserGestures: true,
      child: ImageContainer(height: 200, url: course.artworkUrl));
  }

  _buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(course.name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 20)),
            Text(course.description,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300))
          ]),
    );
  }

  _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 15);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Domain(s): ${course.domainsString}", style: style),
          Text("Level: ${course.difficulty.capitalized()}", style: style),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("${course.contributors}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
