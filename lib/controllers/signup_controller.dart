import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/collections.dart';
import '../Utils/common.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final Rx<TextEditingController> nameController = TextEditingController().obs,
      emailController = TextEditingController().obs,
      passwordController = TextEditingController().obs,
      confirmPasswordController = TextEditingController().obs;
  signupWithEmail()async{
    if(passwordController.value.text==confirmPasswordController.value.text) {
      try{
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.value.text, password: passwordController.value.text).then((value)async{
            String uid= value.user!.uid;
            await usersCollection.doc(uid).set({
              "name":nameController.value.text,
              "email":emailController.value.text,
              "profilePicture":"https://firebasestorage.googleapis.com/v0/b/nileur-music.appspot.com/o/company%2FyfVWUsOo7BOGyalDwLSDgz0AbDs2%2Fpp_1671369389420.jpg?alt=media&token=01ac99d9-89ce-42eb-a19c-20e21ce586df"
            }).then((value) => Get.toNamed("/home",parameters: {"uid":uid}));
      });

    }on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          customToast("Email already in use");
          break;
        case "weak-password":
          customToast("Weak password");
          break;
        case "invalid-email":
          customToast("Invalid email format");
          break;
      }

  }
    }else{
      customToast("Passwords dont match");
    }

  }
  @override
  void dispose() {
nameController.value.dispose();
passwordController.value.dispose();
passwordController.value.dispose();
confirmPasswordController.value.dispose();
super.dispose();
  }
}
