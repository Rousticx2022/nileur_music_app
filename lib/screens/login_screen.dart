import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/controllers/login_controller.dart';
import 'package:nileur_music_app/screens/signup_screen.dart';
import 'package:nileur_music_app/screens/home_screen.dart';

import '../Utils/common.dart';


class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            Image.asset("assests/Nileur.png",),
            const SizedBox(height: 40,),
            Row(
              children: [
                Text(
                  'Login',
                  style: fontMontserrat(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2
                  ),
                ),
                const SizedBox(width: 20,),
                GestureDetector(
                  onTap: ()=>Get.toNamed("/signup"),
                  child: Text(
                    'Sign Up',
                    style: fontMontserrat(
                      color: Color(0xffB7A3CF),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Email',
                style: fontMontserrat(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: controller.emailController.value,
              style: fontMontserrat(color: kTextColor),
              decoration: InputDecoration(
                fillColor: kWhiteColor.withOpacity(.1),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                hintStyle: const TextStyle(fontSize: 16, color: kTextColor),
                hintText: "Enter Email",
              ),
            ),
            SizedBox(height: 20,),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Password',
                style: fontMontserrat(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: controller.passwordController.value,
              style: fontMontserrat(color: kTextColor),
              decoration: InputDecoration(
                fillColor: kWhiteColor.withOpacity(.1),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                hintStyle: const TextStyle(fontSize: 16, color: kTextColor),
                hintText: "Enter Password",
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: fontMontserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            MaterialButton(
              onPressed: ()=>Get.to(HomeScreen()),
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: Text(
                    'Login',
                    style: fontMontserrat(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 'Are you a new user? ',
                  style: fontMontserrat(
                      color: Color(0xffB7A3CF),
                  ),
                ),
                GestureDetector(
                  onTap: ()=>Get.toNamed("/signup"),
                  child: Text(
                    'Sign Up',
                    style: fontMontserrat(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
