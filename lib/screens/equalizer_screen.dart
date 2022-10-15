import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/screens/profile_screen.dart';

class EqualizerScreen extends StatelessWidget {
  const EqualizerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff26133C),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=>Get.to(ProfileScreen()),
                    child: Text(
                      'Equaliser',
                      style: TextStyle(
                          color: Color(0xffB7A3CF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Equaliser',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Switch(
                    value: false,
                    onChanged: (val){},
                    activeColor: Colors.amber,
                    activeTrackColor: Colors.cyan,
                    inactiveThumbColor: Colors.blueGrey.shade600,
                    inactiveTrackColor: Colors.grey.shade400,
                    splashRadius: 50.0,
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
