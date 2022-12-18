import 'package:flutter/material.dart';
import 'package:nileur_music_app/controllers/splash_controller.dart';
import 'package:nileur_music_app/screens/login_screen.dart';
import 'package:get/get.dart';

import '../Utils/common.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assests/Frame 1.png"),
            const SizedBox(height: 30,),
            Image.asset("assests/Nileur.png",),
            const Text(
              'The Music App',
              style: TextStyle(color: Color(0xffC9B6F1), fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
