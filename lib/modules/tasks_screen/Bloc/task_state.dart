part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class GetDataState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  List<TaskModel>? taskData;
  GetDataState({this.isLoading = false, this.isCompleted = false, this.hasError = false, this.taskData});
}

class SetDataState extends TaskState {
  bool isLoading;
  bool isCompleted;
  bool hasError;
  SetDataState({this.isLoading = false, this.isCompleted = false, this.hasError = false});
}
