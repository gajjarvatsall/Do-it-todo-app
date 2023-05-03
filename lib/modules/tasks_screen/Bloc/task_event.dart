part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetPendingTasksEvent extends TaskEvent {
  final String currentUserId;
  GetPendingTasksEvent(this.currentUserId);
}

class GetCompletedTasksEvent extends TaskEvent {
  final String currentUserId;
  GetCompletedTasksEvent(this.currentUserId);
}

class CreateTasksEvent extends TaskEvent {
  final String task;
  final String userId;
  final bool isCompleted;
  CreateTasksEvent(this.task, this.isCompleted, this.userId);
}

class UpdateTasksEvent extends TaskEvent {
  final String task;
  final String id;
  final bool isCompleted;
  UpdateTasksEvent(this.task, this.isCompleted, this.id);
}

class DeleteTasksEvent extends TaskEvent {
  final String id;
  DeleteTasksEvent(this.id);
}
