import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/modules/tasks_screen/repository/task_repo.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<GetPendingTasksEvent>(_getPendingTasks);
    on<GetCompletedTasksEvent>(_getCompletedTasks);
    on<CreateTasksEvent>(_createTasks);
    on<UpdateTasksEvent>(_updateTasks);
    on<DeleteTasksEvent>(_deleteTasks);
  }
  void _getPendingTasks(GetPendingTasksEvent event, Emitter<TaskState> emit) async {
    try {
      emit(GetPendingTasksState(isLoading: true));
      final data = await TaskRepository().getPendingTasks(event.currentUserId);
      emit(GetPendingTasksState(isLoading: false, isCompleted: true, taskData: data));
    } catch (e) {
      emit(GetPendingTasksState(hasError: true));
    }
  }

  void _getCompletedTasks(GetCompletedTasksEvent event, Emitter<TaskState> emit) async {
    try {
      emit(GetCompletedTasksState(isLoading: true));
      final data = await TaskRepository().getCompletedTasks(event.currentUserId);
      emit(GetCompletedTasksState(isLoading: false, isCompleted: true, taskData: data));
    } catch (e) {
      emit(GetCompletedTasksState(hasError: true));
    }
  }

  void _createTasks(CreateTasksEvent event, Emitter<TaskState> emit) async {
    try {
      emit(CreateTasksState(isLoading: true));
      TaskRepository().createTasks(event.task, event.userId, event.isCompleted);
      emit(CreateTasksState(isLoading: false, isCompleted: true));
    } catch (e) {
      emit(GetPendingTasksState(hasError: true));
    }
  }

  void _updateTasks(UpdateTasksEvent event, Emitter<TaskState> emit) async {
    try {
      emit(UpdateTasksState(isLoading: true));
      TaskRepository().updateTasks(event.task, event.id, event.isCompleted);
      emit(UpdateTasksState(isLoading: false, isCompleted: true));
    } catch (e) {
      emit(UpdateTasksState(hasError: true));
    }
  }

  void _deleteTasks(DeleteTasksEvent event, Emitter<TaskState> emit) async {
    try {
      emit(DeleteTasksState(isLoading: true));
      TaskRepository().deleteTasks(event.id);
      emit(DeleteTasksState(isLoading: false, isCompleted: true));
    } catch (e) {
      emit(DeleteTasksState(hasError: true));
    }
  }
}
