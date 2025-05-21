import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Welcome 😊", false],
    ];
  }

  void loadData() {
    if (_myBox.containsKey("TODOLIST")) {
      toDoList = _myBox.get("TODOLIST");
    } else {
      toDoList = [];
    }
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
