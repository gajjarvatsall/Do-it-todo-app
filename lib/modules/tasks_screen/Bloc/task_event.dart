part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class getDataEvent extends TaskEvent {
  final String currentUserId;
  getDataEvent(this.currentUserId);
}

class setDataEvent extends TaskEvent {
  final String task;
  final String userId;
  final bool isCompleted;
  setDataEvent(this.task, this.isCompleted, this.userId);
}
