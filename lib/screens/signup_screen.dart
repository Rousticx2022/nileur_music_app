import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/screens/login_screen.dart';
import 'package:nileur_music_app/screens/home_screen.dart';

class SignUpSCreen extends StatelessWidget {
  const SignUpSCreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff26133C),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
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
                SizedBox(height: 40,),
                Row(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: ()=>Get.to(LoginScreen()),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Color(0xffB7A3CF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Username',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter username',
                      hintStyle: TextStyle(
                        color: Color(0xffB7A3CF),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffDEB747),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15)

                      )
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0xffB7A3CF),
                      ),
                      hintText: 'i.e-abc@gmail.com',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffDEB747),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0xffB7A3CF),
                      ),
                      hintText: 'Enter password (Min. 8 character)',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffDEB747),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15)

                      )
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Confirm password',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Color(0xffB7A3CF),
                      ),
                      hintText: 'Confirm password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffDEB747),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                SizedBox(height: 30,),
                MaterialButton(
                  onPressed: ()=>Get.to(HomeScreen()),
                  color: Color(0xffFAE262),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Color(0xff26133C),
                            fontSize: 20
                        ),
                      ),
                    ),
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
