import 'package:flutter/material.dart';
import 'package:nileur_music_app/screens/login_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff26133C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: ()=> Get.to(LoginScreen()),
              child: Text(
                'Nileur',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xffDEB747),
                  letterSpacing: 2.0
                ),
              ),
            ),
            Text(
              'The Music App',
              style: TextStyle(
                color: Color(0xffB7A3CF),
                fontSize: 15

              ),

            ),
          ],
        ),
      ),
    );
  }
}
