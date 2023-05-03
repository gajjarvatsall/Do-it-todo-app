part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class GetPendingTasksState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  List<TaskModel>? taskData;
  GetPendingTasksState({this.isLoading = false, this.isCompleted = false, this.hasError = false, this.taskData});
}

class GetCompletedTasksState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  List<TaskModel>? taskData;
  GetCompletedTasksState({this.isLoading = false, this.isCompleted = false, this.hasError = false, this.taskData});
}

class CreateTasksState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  CreateTasksState({this.isLoading = false, this.isCompleted = false, this.hasError = false});
}

class UpdateTasksState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  UpdateTasksState({this.isLoading = false, this.isCompleted = false, this.hasError = false});
}

class DeleteTasksState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  DeleteTasksState({this.isLoading = false, this.isCompleted = false, this.hasError = false});
}
