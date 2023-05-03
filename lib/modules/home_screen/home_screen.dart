import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doit/modules/completed_tasks_screen/completed_tasks_screen.dart';
import 'package:doit/modules/profile_screen/profile_screen.dart';
import 'package:doit/modules/tasks_screen/Bloc/task_bloc.dart';
import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/modules/tasks_screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: GNav(
          color: Colors.grey.shade500,
          selectedIndex: selectedIndex,
          onTabChange: _onItemTapped,
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[100]!,
          tabs: const [
            GButton(
              icon: Icons.notes,
              text: 'Tasks',
            ),
            GButton(
              icon: Icons.task_alt,
              text: 'Completed',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.task_alt),
            //   label: 'Completed',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'Profile',
            // ),
          ],
        ),
      ),
    );
  }
}
