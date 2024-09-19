import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagement/task.dart';


Future<void> storingDatatoPreff(bool isuserloggedin) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isloggedin", isuserloggedin);
}

Future<bool> gettingBoolData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? data = prefs.getBool("isloggedin");
  if(data == null){
    data = false;
  }

  return data;
}

void deletingString() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("isloggedin");
}

class TaskProvider
{
  static const String _taskListKey = 'task_list';
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? taskListString = prefs.getString(_taskListKey);

    if (taskListString != null) {
      List<dynamic> taskListJson = json.decode(taskListString);
      return taskListJson.map((json) => Task.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> addTask(Task task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await _saveTasks(tasks);
  }

   Future<void> editTask(int index, Task task) async {
    final tasks = await getTasks();
    tasks[index] = task;
    await _saveTasks(tasks);
  }
   Future<void> deleteTask(int index) async {
    final tasks = await getTasks();
    tasks.removeAt(index);
    await _saveTasks(tasks);
  }
  Future<void> _saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String taskListString = json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_taskListKey, taskListString);
  }
}