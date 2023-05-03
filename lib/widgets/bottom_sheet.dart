import 'package:doit/modules/tasks_screen/models/task_model.dart';
import 'package:doit/widgets/text_field.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.taskList,
    required this.todoController,
    required this.checkButtonClick,
    required this.cancleButtonClick,
  });

  final List<TaskModel>? taskList;
  final TextEditingController todoController;
  final Function() checkButtonClick;
  final Function() cancleButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 2.0,
          )
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
                onPressed: cancleButtonClick,
                icon: const Icon(Icons.close),
              ),
              const Text("Add New Task"),
              IconButton(
                onPressed: checkButtonClick,
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(controller: todoController, labletxt: "New Task", obscure: false),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
