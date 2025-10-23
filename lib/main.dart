import 'package:flutter/material.dart';
import 'Task_Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/home.png', fit: BoxFit.cover),
                SizedBox(height: 31),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64),
                  child: Text(
                    'Task Management & To-Do List',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 54),
                  child: Text(
                    'This productive tool is designed to help you better manage your task  project-wise conveniently!',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => TaskHome()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff007AFF),
                    fixedSize: Size(331, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Let’s Start',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
