import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/widgets/bottom_sheet.dart';
import 'package:doit/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController taskController = TextEditingController();
  List<TaskModel>? taskData = [];
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _fetchPendingTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetPendingTasksState && state.isCompleted) {
              taskData = state.taskData;
            }
            if (state is DeleteTasksState && state.isCompleted) {
              _fetchPendingTaskList();
            }
            if (state is UpdateTasksState && state.isCompleted) {
              _fetchPendingTaskList();
            }
          },
          builder: (context, state) {
            return state is GetPendingTasksState && state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black,
                  ))
                : taskData!.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/task_screen.svg',
                              width: MediaQuery.of(context).size.width / 1.5),
                          Text(
                            "Add a new task",
                            style: TextStyle(color: Colors.grey[500]),
                          )
                        ],
                      ))
                    : AnimationLimiter(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: taskData?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            flex: 1,
                                            onPressed: (value) {
                                              showBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return CustomBottomSheet(
                                                        taskList: taskData,
                                                        todoController: taskController,
                                                        checkButtonClick: () {
                                                          _updateTask(
                                                              taskController.text, false, taskData?[index].id ?? "");
                                                          Navigator.pop(context);
                                                        },
                                                        cancleButtonClick: () {
                                                          Navigator.pop(context);
                                                        });
                                                  });
                                            },
                                            backgroundColor: const Color(0xFF7BC043),
                                            foregroundColor: Colors.white,
                                            icon: Icons.edit,
                                            label: 'Edit',
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SlidableAction(
                                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            onPressed: (value) {
                                              _deleteTask(taskData?[index].id ?? "");
                                            },
                                            backgroundColor: Colors.redAccent,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        // tileColor: Colors.grey.shade200,
                                        leading: Checkbox(
                                          activeColor: Colors.black,
                                          value: taskData?[index].isCompleted,
                                          onChanged: (newValue) {
                                            taskData?[index].isCompleted = newValue;
                                            _updateTask(taskData?[index].task ?? "",
                                                taskData?[index].isCompleted ?? false, taskData?[index].id ?? "");
                                          },
                                        ),
                                        title: Text("${taskData?[index].task}"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
          },
        ),
        BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is CreateTasksState && state.isCompleted) {
              taskController.clear();
              _fetchPendingTaskList();
            }
          },
          builder: (context, state) {
            return Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return CustomBottomSheet(
                              cancleButtonClick: () {
                                Navigator.pop(context);
                              },
                              checkButtonClick: () {
                                if (taskController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text("Please add a task")));
                                } else {
                                  BlocProvider.of<TaskBloc>(context).add(CreateTasksEvent(
                                    taskController.text,
                                    false,
                                    auth.currentUser!.uid.toString(),
                                  ));
                                }
                                Navigator.pop(context);
                              },
                              todoController: taskController,
                              taskList: taskData,
                            );
                          });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ),
            );
          },
        ),
      ],
    );
  }

  void _fetchPendingTaskList() {
    BlocProvider.of<TaskBloc>(context).add(GetPendingTasksEvent(auth.currentUser!.uid));
  }

  void _deleteTask(String id) {
    BlocProvider.of<TaskBloc>(context).add(DeleteTasksEvent(id));
  }

  void _updateTask(String task, bool isCompleted, String id) {
    BlocProvider.of<TaskBloc>(context).add(UpdateTasksEvent(task, isCompleted, id));
  }
}
