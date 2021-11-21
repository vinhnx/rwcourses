import 'package:flutter/material.dart';
import 'package:rwcourses/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterStateContainer extends StatefulWidget {
  final Widget child;

  const FilterStateContainer({Key key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FilterState();

  static FilterState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_FilterInheritedWidget>()
        .state;
  }
}

class FilterState extends State<FilterStateContainer> {
  int filterValue = Constants.allFilter;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _loadvalue();
  }

  _loadvalue() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;

      setState(() {
        filterValue = _preferences.getInt(Constants.filterKey);
      });
    });
  }

  updateFilterValue(int? value) {
    if (value != null) {
      setState(() {
        _preferences.setInt(Constants.filterKey, value);
        filterValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _FilterInheritedWidget(state: this, child: widget.child);
  }
}

class _FilterInheritedWidget extends InheritedWidget {
  final FilterState state;

  _FilterInheritedWidget({Key? key, required this.state, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
