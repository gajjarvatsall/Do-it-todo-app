import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:flutter/foundation.dart';

class TaskRepository {
  Future<List<TaskModel>> getPendingTasks(String currentUserId) async {
    List<TaskModel> taskList = [];
    try {
      final tasks = await FirebaseFirestore.instance
          .collection('tasks')
          .where("userId", isEqualTo: currentUserId)
          .where("isCompleted", isEqualTo: false)
          .get();
      tasks.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });

      return taskList;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> getCompletedTasks(String currentUserId) async {
    List<TaskModel> taskList = [];
    try {
      final tasks = await FirebaseFirestore.instance
          .collection('tasks')
          .where("userId", isEqualTo: currentUserId)
          .where("isCompleted", isEqualTo: true)
          .get();
      tasks.docs.forEach((element) {
        return taskList.add(TaskModel.fromJson(element.data()));
      });

      return taskList;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> createTasks(String task, String userId, bool isCompleted) async {
    final response = await FirebaseFirestore.instance.collection("tasks");
    final docId = response.doc().id;
    response.doc(docId).set({"task": task, "isCompleted": isCompleted, "userId": userId, "id": docId});
  }

  Future<void> updateTasks(String task, String id, bool isCompleted) async {
    await FirebaseFirestore.instance.collection("tasks").doc(id).update({"task": task, "isCompleted": isCompleted});
  }

  Future<void> deleteTasks(String id) async {
    await FirebaseFirestore.instance.collection("tasks").doc(id).delete();
  }
}
