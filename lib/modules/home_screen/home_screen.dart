import 'package:doit/modules/completed_tasks_screen/completed_tasks_screen.dart';
import 'package:doit/modules/profile_screen/profile_screen.dart';
import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/modules/tasks_screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<dynamic> homeScreenList = [const TasksScreen(), const CompletedTasksScreen(), const ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('D O I T'),
      ),
      body: SafeArea(
          child: Center(
        child: homeScreenList[selectedIndex],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
