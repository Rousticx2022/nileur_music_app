import 'package:flutter/material.dart';
import 'package:nileur_music_app/screens/login_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  loadApp() {
    Future.delayed(Duration(seconds: 2), (){
      Get.to(() => LoginScreen());
    });
  }

  @override
  void initState() {
    loadApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff26133C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nileur',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Color(0xffDEB747), letterSpacing: 2.0),
            ),
            Text(
              'The Music App',
              style: TextStyle(color: Color(0xffB7A3CF), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
