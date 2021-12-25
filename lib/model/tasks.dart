import 'package:flutter/material.dart';
import 'task.dart';

class Tasks with ChangeNotifier {
  int maxId = 0;
  List<Task> tasklist = <Task>[];

  void add(Task task) {
    task.id = maxId;
    maxId++;
    tasklist.add(task);
    tasklist.sort(comp);
    notifyListeners();
  }

  void delete(Task task) {
    tasklist.removeAt(tasklist.indexOf(task));
    notifyListeners();
  }

  void update(Task task) {
    var t = findById(task.id);
    t.limitDate = task.limitDate;
    t.taskName = task.taskName;

    tasklist.sort(comp);
    notifyListeners();
  }

  Task findById(int id) => tasklist.firstWhere((task) => task.id == id);

  int comp(Task a, Task b) {
    return a.limitDate.compareTo(b.limitDate) == 0
        ? a.taskName.compareTo(b.taskName)
        : a.limitDate.compareTo(b.limitDate);
  }
}
