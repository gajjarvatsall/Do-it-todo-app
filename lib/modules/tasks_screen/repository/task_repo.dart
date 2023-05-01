import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:flutter/foundation.dart';

class TaskRepository {
  Future<List<TaskModel>> getData(String currentUserId) async {
    List<TaskModel> taskList = [];
    try {
      final tasks =
          await FirebaseFirestore.instance.collection('tasks').where("userId", isEqualTo: currentUserId).get();
      tasks.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });

      return taskList;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> setData(String task, String userId, bool isCompleted) async {
    await FirebaseFirestore.instance
        .collection("tasks")
        .doc()
        .set({"task": task, "isCompleted": isCompleted, "userId": userId});
  }
}
