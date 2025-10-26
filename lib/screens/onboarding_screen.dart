import 'package:flutter/material.dart';
import 'package:to_do_list_app/screens/main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/start.png', fit: BoxFit.cover),

            Padding(
              padding: const EdgeInsets.only(
                top: 31,
                bottom: 20,
                left: 64,
                right: 79,
              ),
              child: const Text(
                'Task Management &\nTo-Do List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff24252C),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 54, right: 73),
              child: const Text(
                'This productive tool is designed to help\nyou better manage your task\nproject-wise consistently!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6E6A7C),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 73, left: 22, right: 37),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff007AFF),
                  fixedSize: Size(331, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        'Let\'s Start',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      bottom: 0,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
