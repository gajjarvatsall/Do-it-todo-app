import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<TaskModel>? taskData = [];
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetCompletedTasksState && state.isCompleted) {
          taskData = state.taskData;
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
                      SvgPicture.asset('assets/images/completed_screen.svg',
                          width: MediaQuery.of(context).size.width / 1.5),
                    ],
                  ))
                : AnimationLimiter(
                    child: ListView.builder(
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
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  leading: Checkbox(
                                    activeColor: Colors.black,
                                    value: taskData?[index].isCompleted,
                                    onChanged: (value) => true,
                                  ),
                                  title: Text("${taskData?[index].task}"),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
      },
    );
  }

  void _fetchCompletedTaskList() {
    BlocProvider.of<TaskBloc>(context).add(GetCompletedTasksEvent(auth.currentUser!.uid));
  }
}
