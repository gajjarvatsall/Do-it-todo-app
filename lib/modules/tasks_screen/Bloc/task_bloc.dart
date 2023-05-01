import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/modules/tasks_screen/repository/task_repo.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<getDataEvent>(_getTasks);
  }
  void _getTasks(getDataEvent event, Emitter<TaskState> emit) async {
    try {
      emit(GetDataState(isLoading: true));
      final data = await TaskRepository().getData();
      emit(GetDataState(isLoading: false, isCompleted: true, taskData: data));
    } catch (e) {
      emit(GetDataState(hasError: true));
    }
  }
}
