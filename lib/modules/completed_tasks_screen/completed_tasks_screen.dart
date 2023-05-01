import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Completed Tasks Screen"),
        ],
      ),
    );
  }
}
