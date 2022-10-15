import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/screens/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff26133C),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back, color: Colors.white,size: 25,),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Color(0xffB7A3CF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.settings_outlined,color: Colors.white, size: 25,),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),

                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Username',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                ),
              ),
              SizedBox(height: 25),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87.withAlpha(180),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My purchase',
                        style: TextStyle(color: Color(0xffB7A3CF),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                        ),
                      ),
                      DropdownButton(
                        items: [
                          // DropdownMenuItem(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Binding lights',
                          //         style: TextStyle(color: Color(0xffB7A3CF),
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.bold,
                          //             letterSpacing: 1
                          //         ),
                          //       ),
                          //       Row(
                          //         children: [
                          //           Text('03.00', style: TextStyle(color: Colors.white),),
                          //           SizedBox(width: 5,),
                          //           IconButton(
                          //             onPressed: (){},
                          //             icon: Icon(Icons.play_circle_filled_rounded, size: 40, color: Color(0xffDEB747),),
                          //           ),
                          //
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // DropdownMenuItem(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Cheap thrills',
                          //         style: TextStyle(color: Color(0xffB7A3CF),
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.bold,
                          //             letterSpacing: 1
                          //         ),
                          //       ),
                          //       Row(
                          //         children: [
                          //           Text('02.50', style: TextStyle(color: Colors.white),),
                          //           SizedBox(width: 5,),
                          //           IconButton(
                          //             onPressed: (){},
                          //             icon: Icon(Icons.play_circle_filled_rounded, size: 40, color: Color(0xffDEB747),),
                          //           ),
                          //
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // )

                        ],
                        onChanged: (val){},
                        iconEnabledColor: Colors.white,
                      )
                    ],
                  ),
                )
              ),
              SizedBox(height: 45),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'My playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                  ),
                ),
              ),
              SizedBox(height: 50),
              trackCardList(
                title: 'Infinity',
                artistName: 'James young',
              ),
              trackCardList(
                title: 'Stareo heart',
                artistName: 'Gym brands',
              ),
              trackCardList(
                title: 'CHeap thrills',
                artistName: 'Sia',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
