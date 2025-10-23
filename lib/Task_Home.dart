import 'package:flutter/material.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({Key? key}) : super(key: key);

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsetsGeometry.fromLTRB(16, 35, 16, 64) ,
      child: Column(
        children: [
          Text('Good Morning, Ali'),
          Text('Monday, July 14'),
          Column(
            children: [
              Text('My Day Progress'),
              LinearProgressIndicator(),
              Text('6/10 Tasks Completed')],
              ),
              ListView(),
              FloatingActionButton(onPressed: (){},)],
              ),
              ),
              bottomNavigationBar: BottomNavigationBar(items: const[BottomNavigationBarItem(icon: Icon(Icons.home))]),
    );
  }
}
