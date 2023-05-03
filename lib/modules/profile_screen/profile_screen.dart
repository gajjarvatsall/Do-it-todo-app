import 'package:doit/modules/login_screen/bloc/auth_bloc.dart';
import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/widgets/elevated_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  List<TaskModel>? pendingTaskData = [];
  List<TaskModel>? completedTaskData = [];

  void _accountSignOut(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutRequested(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCompletedTaskList();
    _fetchPendingTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is GetPendingTasksState && state.isCompleted) {
          pendingTaskData = state.taskData;
        }
        if (state is GetCompletedTasksState && state.isCompleted) {
          completedTaskData = state.taskData;
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const Text("User Profile"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  "${auth.currentUser!.photoURL}",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                "${auth.currentUser!.displayName}",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${auth.currentUser!.email}",
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  height: MediaQuery.of(context).size.height / 7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [const Text("Pending Tasks"), Text("${pendingTaskData?.length}")],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [const Text("Completed Tasks"), Text("${completedTaskData?.length}")],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomElevatedButtonIcon(
                  onTap: () {
                    _accountSignOut(context);
                    Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
                  },
                  text: "Sign Out",
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ))
            ],
          ),
        );
      },
    );
  }

  void _fetchCompletedTaskList() {
    BlocProvider.of<TaskBloc>(context).add(GetCompletedTasksEvent(auth.currentUser!.uid));
  }

  void _fetchPendingTaskList() {
    BlocProvider.of<TaskBloc>(context).add(GetPendingTasksEvent(auth.currentUser!.uid));
  }
}
