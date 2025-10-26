import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task_model.dart';
import 'package:to_do_list_app/utilsutils/colors.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const TaskTile({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: onToggle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) {
            onToggle();
          },
          activeColor: kPrimaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: task.isCompleted ? kLightGrey : kDarkGrey,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
