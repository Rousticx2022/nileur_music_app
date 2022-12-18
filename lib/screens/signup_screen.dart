import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/Utils/form_validators.dart';
import 'package:nileur_music_app/screens/login_screen.dart';
import 'package:nileur_music_app/screens/home_screen.dart';

import '../Utils/common.dart';
import '../controllers/signup_controller.dart';

class SignUpSCreen extends GetView<SignupController> {
  const SignUpSCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColor,
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              Image.asset(
                "assests/Nileur.png",
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    'Sign Up',
                    style: fontMontserrat(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 2),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const LoginScreen()),
                    child: Text(
                      'Log in',
                      style: fontMontserrat(
                        color: const Color(0xffB7A3CF),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Username',
                  style: fontMontserrat(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.nameController.value,
                style: fontMontserrat(color: kTextColor),
                decoration: InputDecoration(
                  fillColor: kWhiteColor.withOpacity(.1),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                  hintStyle: const TextStyle(fontSize: 16, color: kTextColor),
                  hintText: "Enter UserName",
                ),
                validator: nameValidator,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Email',
                  style: fontMontserrat(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller:controller.emailController.value,
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
                validator: emailValidator,
              ),

              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Password',
                  style: fontMontserrat(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                validator: passwordValidator,
              ),

              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Confirm password',
                  style: fontMontserrat(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.confirmPasswordController.value,
                style: fontMontserrat(color: kTextColor),
                decoration: InputDecoration(
                  fillColor: kWhiteColor.withOpacity(.1),
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                  hintStyle: const TextStyle(fontSize: 16, color: kTextColor),
                  hintText: "Confirm Password",
                ),
                validator: passwordValidator,
              ),

              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: ()=>controller.signupWithEmail(),
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: fontMontserrat(color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
