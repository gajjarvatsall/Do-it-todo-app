import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:flutter/foundation.dart';

class TaskRepository {
  Future<List<TaskModel>> getData() async {
    List<TaskModel> taskList = [];
    try {
      final tasks = await FirebaseFirestore.instance.collection('tasks').get();
      tasks.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });

      return taskList;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
