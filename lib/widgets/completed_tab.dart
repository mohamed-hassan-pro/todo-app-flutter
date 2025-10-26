import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task_model.dart';
import 'package:to_do_list_app/utilsutils/colors.dart';
import 'package:to_do_list_app/widgets/task_tile.dart';

class CompletedTab extends StatelessWidget {
  final List<Task> completedTasksList;
  final Function(Task) onToggle;
  final double progress;
  final int completedTasks;
  final int totalTasks;

  const CompletedTab({
    super.key,
    required this.completedTasksList,
    required this.onToggle,
    required this.progress,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const Text(
          'Completed Tasks',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: kDarkGrey,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'My Day Progress',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kDarkGrey,
          ),
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: kLightBlue,
          color: kPrimaryBlue,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 8),
        Text(
          '$completedTasks/$totalTasks Tasks Completed',
          style: const TextStyle(fontSize: 14, color: kLightGrey),
        ),
        const SizedBox(height: 24),
        const Text(
          'Tasks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kDarkGrey,
          ),
        ),
        const SizedBox(height: 12),
        if (completedTasksList.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'No completed tasks yet.',
                style: TextStyle(fontSize: 16, color: kLightGrey),
              ),
            ),
          )
        else
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: completedTasksList.length,
            itemBuilder: (context, index) {
              final task = completedTasksList[index];
              return TaskTile(task: task, onToggle: () => onToggle(task));
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        const SizedBox(height: 80),
      ],
    );
  }
}
