import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController taskController = TextEditingController();
  bool isChecked = false;
  List<TaskModel>? taskData = [];
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskBloc, TaskState>(
        //  bloc: TaskBloc()..add(getDataEvent(auth.currentUser!.uid)),
        listener: (context, state) {
          // TODO: implement listener
          if (state is GetDataState && state.isCompleted) {
            taskData = state.taskData;
          }
        },
        builder: (context, state) {
          return state is GetDataState && state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: taskData?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Slidable(
                        endActionPane: const ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 1,
                              onPressed: null,
                              backgroundColor: Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              borderRadius:
                                  BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
                              onPressed: null,
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
                          tileColor: Colors.grey.shade200,
                          leading: Checkbox(
                            activeColor: Colors.black,
                            value: isChecked,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  isChecked = !isChecked;
                                },
                              );
                            },
                          ),
                          title: Text("${taskData?[index].task}"),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is SetDataState && state.isCompleted) {
            taskController.clear();
            _fetchTaskList();
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 25.0,
                              offset: Offset(0, 5))
                        ],
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close),
                              ),
                              const Text("Add New Task"),
                              IconButton(
                                onPressed: () {
                                  if (taskController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text("Please add a task")));
                                  } else {
                                    BlocProvider.of<TaskBloc>(context).add(
                                        setDataEvent(taskController.text, isChecked, auth.currentUser!.uid.toString()));
                                  }
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.check),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(controller: taskController, labletxt: "New Task", obscure: false),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ));
        },
      ),
    );
  }

  void _fetchTaskList() {
    BlocProvider.of<TaskBloc>(context).add(getDataEvent(auth.currentUser!.uid));
  }
}
