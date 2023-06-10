import 'package:hive_flutter/hive_flutter.dart';

class TasksDb {
  //instance of tasklist created from home page as a database
  List taskList = [];
  final _myBox = Hive.box("mybox");

//first task when run

  void createFirstTask() {
    taskList = [
      ["Wash Clothes", true],
      ["Watch Tutorial", false],
    ];
  }

  //

  void loadTask() {
    taskList = _myBox.get("taskList");
  }

  void updateDb() {
    _myBox.put("taskList", taskList);
  }
}
