import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/models/task_model.dart';
import 'package:to_do_list_app/widgets/add_task_modal.dart';
import 'package:to_do_list_app/widgets/completed_tab.dart';
import 'package:to_do_list_app/widgets/home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Task> _allTasks = [
    Task(id: '1', title: 'Design New UI For Dashboard', isCompleted: true),
    Task(id: '2', title: 'Design New UI For Profile', isCompleted: false),
    Task(
      id: '3',
      title: 'Fix Bug on Login Screen',
      isCompleted: false,
      priority: Priority.high,
    ),
    Task(id: '4G', title: 'Create Wireframes', isCompleted: true),
  ];

  void _toggleTaskStatus(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _addTask(Task task) {
    setState(() {
      _allTasks.add(task);
    });
  }

  void _showAddTaskModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTaskModal(onAddTask: _addTask),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalTasks = _allTasks.length;
    final int completedTasks = _allTasks
        .where((task) => task.isCompleted)
        .length;
    final double progress = totalTasks == 0 ? 0 : completedTasks / totalTasks;
    final String todayDate = DateFormat('EEEE, MMMM d').format(DateTime.now());

    final List<Widget> tabs = [
      HomeTab(
        pendingTasks: _allTasks.where((task) => !task.isCompleted).toList(),
        onToggle: _toggleTaskStatus,
        progress: progress,
        completedTasks: completedTasks,
        totalTasks: totalTasks,
        date: todayDate,
      ),
      CompletedTab(
        completedTasksList: _allTasks
            .where((task) => task.isCompleted)
            .toList(),
        onToggle: _toggleTaskStatus,
        progress: progress,
        completedTasks: completedTasks,
        totalTasks: totalTasks,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: tabs[_currentIndex]),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskModal,
        backgroundColor: Color(0xff007AFF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        shadowColor: Color(0xff000000),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Color(0xff007AFF).withOpacity(0.15),
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined, color: Color(0xff007AFF)),
            icon: Icon(Icons.home_outlined, color: Color(0xff1E1E1E)),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.check_circle_outline,
              color: Color(0xff007AFF),
            ),
            icon: Icon(Icons.check_circle_outline, color: Color(0xff1E1E1E)),
            label: 'Completed',
          ),
        ],
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w500),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }
}
