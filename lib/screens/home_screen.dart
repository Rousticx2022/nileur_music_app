import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/screens/equalizer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff26133C),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(onTap: ()=>Get.to(EqualizerScreen()),child: CircleAvatar())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar()
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  'Good evening,',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Color(0xffB7A3CF),
                  ),
                ),
                SizedBox(height: 2,),
                Text(
                  'Jack',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30,),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade600.withAlpha(55),
                    hintStyle: TextStyle(
                      color: Color(0xffB7A3CF),
                    ),
                    hintText: 'Search songs, Artists,..',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25)
                    )
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recently played',
                      style: TextStyle(
                        color: Color(0xffB7A3CF),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                      ),
                    ),
                    Text(
                      'More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 170,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      playListCard(
                        title: 'Blinding lights',
                        subTitle: 'The weekend',
                      ),
                      playListCard(
                        title: 'Unstopable',
                        subTitle: 'Sia',
                      ),
                      playListCard(
                        title: 'S.T.A',
                        subTitle: 'Hans Zim',
                      ),
                      playListCard(
                        title: 'S.T.A',
                        subTitle: 'Hans Zim',
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                          color: Color(0xffB7A3CF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      ),
                    ),
                    Text(
                      'More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      categoryCard(name: 'Nileur',),
                      categoryCard(name: 'Divine music',),
                      categoryCard(name: 'Stratch',),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Popular tracks',
                  style: TextStyle(
                      color: Color(0xffB7A3CF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                  ),
                ),
                SizedBox(height: 30,),
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
      ),
    );
  }
}

class trackCardList extends StatelessWidget {
  final String title;
  final String artistName;

  const trackCardList({super.key, required this.title, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 30,),
              SizedBox(width: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    '$artistName',
                    style: TextStyle(
                      color: Color(0xffB7A3CF),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.play_circle_filled_rounded, size: 40, color: Color(0xffDEB747),),
              ),
              SizedBox(width: 0,),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.file_download_outlined, size: 30,color: Color(0xffDEB747),),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class categoryCard extends StatelessWidget {
  final String name;

  const categoryCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade600.withAlpha(55),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$name',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
      ),
    );
  }
}

class playListCard extends StatelessWidget {

  final String title;
  final String subTitle;

  const playListCard({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30,),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          SizedBox(height: 5,),
          Text(
            '$title',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              fontSize: 15,

            ),
          ),
          SizedBox(height: 5,),
          Text(
            '$subTitle',
            style: TextStyle(
              color: Color(0xffB7A3CF),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
