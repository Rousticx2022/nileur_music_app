import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/common.dart';
import '../Utils/progress_dialog_utils.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();

  final Rx<TextEditingController> emailController = TextEditingController().obs,
      passwordController = TextEditingController().obs;
  emailLogin() async {
    if (!formKey.currentState!.validate()) return;
    ProgressDialogUtils.showProgressDialog();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.value.text, password: passwordController.value.text)
          .then((value) async {
        String uid = value.user!.uid;


        customToast("Welcome");
        Get.offAllNamed("/home", parameters: {"uid": uid});
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          customToast("Account not found");
          break;
        case "wrong-password":
          customToast("Wrong password");
          break;
        case "invalid-email":
          customToast("Invalid email format");
          break;
      }
    }
  }
}