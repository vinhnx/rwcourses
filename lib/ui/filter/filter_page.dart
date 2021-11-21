import 'package:flutter/material.dart';
import 'package:rwcourses/constants.dart';
import 'package:rwcourses/ui/filter/filter_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../strings.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int _filterValue = Constants.allFilter;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();

    // https://github.com/flutter/flutter/issues/65334#issuecomment-873217346
    _initPreferences().whenComplete(() {
      _loadValue();
      setState(() {}); // IMPORTANT
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(title: Text(Strings.filter)),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterWidget(
                    value: Constants.iosFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.ios),
                FilterWidget(
                    value: Constants.androidFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.android),
                FilterWidget(
                    value: Constants.flutterFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.flutter),
                FilterWidget(
                    value: Constants.macosFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.macos),
                FilterWidget(
                    value: Constants.sssFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.sss),
                FilterWidget(
                    value: Constants.unityFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.unity),
                FilterWidget(
                    value: Constants.allFilter,
                    groupValue: _filterValue,
                    onChanged: _handleFilterValueChange,
                    text: Strings.all)
              ],
            )));
  }

  _handleFilterValueChange(int? value) async {
    setState(() {
      if (value != null) {
        _filterValue = value;
        prefs?.setInt(Constants.filterKey, value);
      }
    });
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
