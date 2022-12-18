import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/Utils/collections.dart';
import 'package:remixicon/remixicon.dart';

import '../Utils/common.dart';
import '../controllers/player_controller.dart';
import '../screens/equalizer_screen.dart';
import 'like_button.dart';

class CustomAudioPlayer extends StatefulWidget {
  const CustomAudioPlayer({Key? key}) : super(key: key);

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool isRepeat = false;
  Color color = kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return GetX<PlayerController>(
        init: PlayerController(),
        builder: (playerController) {
          return Scaffold(
            backgroundColor: kBlackColor,
            appBar: AppBar(
              backgroundColor: kBlackColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                color: kPrimaryColor,
                onPressed: () => Get.back(),
              ),
              title: bodyText(text: "Player",),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: playerController.playingMusic["poster"].isEmpty
                        ? Container(
                            height: context.height / 2,
                            width: context.width - 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTextColor),
                          )
                        : CachedNetworkImage(
                            imageUrl: '${playerController.playingMusic["poster"]}',
                            placeholder: (c, s) => Image.asset("assests/placeholder4.png"),
                            height: context.height / 2,
                            width: context.width - 40,
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        bodyText(text: playerController.playingMusic["title"], fontColor: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 20),
                        bodyText(
                            text: playerController.playingMusic["artists"].join(", "),
                            fontColor: Colors.grey.shade300,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: ()=>Get.to(const EqualizerScreen()),
                            child: Image.asset("assests/Vector.png")),
                        LikeButton(uid: playerController.uid, musicID: playerController.playingMusic["id"]),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StreamBuilder<Duration>(
                      stream: playerController.player.positionStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return SliderTheme(
                          data: SliderThemeData(),
                          child: Slider(
                            activeColor: kPrimaryColor,
                            inactiveColor: Colors.white12,
                            thumbColor: Color(0xffFF0EE7),
                            value: positionData!.inSeconds.toDouble(),
                            min: Duration.zero.inSeconds.toDouble(),
                            max: (playerController.player.duration ?? Duration.zero).inSeconds.toDouble(),
                            onChanged: (value) {
                              playerController.player.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder<Duration>(
                              stream: playerController.player.positionStream,
                              builder: (context, positionSnap) {
                                if (!positionSnap.hasData) return Text(printDuration(const Duration(seconds: 0)));
                                return bodyText(text: printDuration(positionSnap.data!), fontSize: 12, fontWeight: FontWeight.normal, fontColor: kWhiteColor);
                              }),
                          bodyText(
                              text: printDuration(playerController.player.duration ?? Duration.zero),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontColor: kWhiteColor),
                        ],
                      ),
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "assests/loop.png",
                        width: 30,
                      ),
                      color: kWhiteColor,
                      onPressed: () {
                        print(isRepeat);
                        if (isRepeat == false) {
                          playerController.seekRepeat();
                          setState(() {
                            isRepeat = true;
                            color = Colors.green;
                          });
                        } else if (isRepeat == true) {
                          playerController.seekRepeatRelease();
                          color = Colors.blue;
                        }
                      },
                    ), //Shuffle Icon

                    GestureDetector(
                      onTap: () => playerController.seekReverse(),
                      child: const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Remix.skip_forward_line,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    GestureDetector(
                      onTap: () => playerController.togglePlay(),
                      child: Obx(
                        () => Container(
                          height: 65,
                          width: 65,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                          child: Icon(
                            playerController.playing.value ? Remix.pause_fill : Remix.play_fill,
                            color: kWhiteColor,
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => playerController.seekNext(),
                        child:const Icon(
                          Remix.skip_forward_line,
                          color: kWhiteColor,
                        )),

                    //Playlist Button
                    IconButton(
                        onPressed: () async{
                          await usersCollection.doc(playerController.uid).collection("myPlayList").doc(playerController.playingMusic["id"]).set({"addedOn":DateTime.now(),}).then((value) => customToast("Added to your playlist"));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: kWhiteColor,
                        ))
                  ],
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: kBlackColor,
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 63,
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kWhiteColor.withOpacity(.2)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const  Icon(
                            Icons.file_download_outlined,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                          const SizedBox(width: 5,),
                          Text("Purchase",style: fontMontserrat(color: kWhiteColor,fontSize: 20),)
                        ],
                      ),
                    )
                  ),

                ],
              ),
            ),
          );
        });
  }
}
