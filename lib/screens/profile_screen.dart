import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/Utils/collections.dart';
import 'package:nileur_music_app/Utils/common.dart';
import 'package:nileur_music_app/controllers/profile_controller.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:remixicon/remixicon.dart';

import '../controllers/player_controller.dart';
import '../widgets/custom_music_player.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:kBlackColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon:const Icon(Icons.arrow_back, color: Colors.white,size: 25,),
          ),
          title: Text(
            'Profile',
            style: fontMontserrat(
                color: kWhiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1
            ),
          ),
          actions:const [
            Icon(Icons.settings_outlined,color: Colors.white, size: 25,),
          ],
        ),
        body: StreamBuilder(
          stream: usersCollection.doc(controller.uid).snapshots(),
          builder: (context,uSnap) {
            if(!uSnap.hasData) return customProgressIndicator();
            DocumentSnapshot udata=uSnap.data!;
            return ListView(
              padding:const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: udata["profilePicture"].isEmpty?
                  Image.asset("assests/placeholderProfile.png",height: Get.height/4,width: Get.width/4,):
                  CachedNetworkImage(
                    imageUrl: udata["profilePicture"],
                    fit: BoxFit.cover,
                    height: Get.height/4,width: Get.width/4,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      udata["name"],
                      style: fontMontserrat(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      ),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                        onTap: ()=>controller.editProfile(udata),
                        child: Image.asset("assests/edit.png"))
                  ],
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
                       const  Text(
                          'My purchase',
                          style: TextStyle(color: Color(0xffB7A3CF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1
                          ),
                        ),
                        DropdownButton(
                          items: [


                          ],
                          onChanged: (val){},
                          iconEnabledColor: Colors.white,
                        )
                      ],
                    ),
                  )
                ),
                const SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'My playlist',
                    style: fontMontserrat(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1
                    ),
                  ),
                ),
                SizedBox(height: 50),
                PaginateFirestore(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  query: usersCollection.doc(controller.uid!).collection("myPlayList").orderBy("addedOn",descending: true),
                 itemBuilderType: PaginateBuilderType.listView,
                 itemBuilder: (context,documentSnapshots,index){
                    DocumentSnapshot myList=documentSnapshots[index];
                   return StreamBuilder(
                     stream: musicCollections.doc(myList.id).snapshots(

                     ),
                     builder: (context,mSnap) {
                       if(!mSnap.hasData)return customProgressIndicator();
                       DocumentSnapshot music=mSnap.data!;
                       return ListTile(
                         leading: music["poster"].isEmpty
                             ? Container(
                           height: 50,
                           width: 50,
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTextColor),
                         )
                             : CachedNetworkImage(
                           imageUrl: music["poster"],
                           fit: BoxFit.contain,
                           height: 50,
                           width: 50,
                         ),
                         title: Text(music["title"],style: fontMontserrat(color: kWhiteColor),),
                         subtitle: Text(music["artist"].join(","),style: fontMontserrat(color: kTextColor),),
                         trailing: IconButton(
                           onPressed: () {
                             controller.pController.initializePlayer(music: music);
                           },
                           icon:  Obx(()=>Icon(controller.pController.playing.value ? Remix.pause_circle_fill : Remix.play_circle_fill,
                             size: 40,
                             color: kPrimaryColor,
                           )),
                         ),
                       );
                     }
                   );
                 },
                )
                // trackCardList(
                //   title: 'Infinity',
                //   artistName: 'James young',
                // ),
                // trackCardList(
                //   title: 'Stareo heart',
                //   artistName: 'Gym brands',
                // ),
                // trackCardList(
                //   title: 'CHeap thrills',
                //   artistName: 'Sia',
                // ),
              ],
            );
          }
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetX<PlayerController>(
                init: PlayerController(),
                builder: (playerController) {
                  return playerController.playerInitialized.value
                      ? Container(
                    decoration: const BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: kWhiteColor, width: 0.2))),
                    child: Obx(
                          () => ListTile(
                        onTap: () => Get.to(() => const CustomAudioPlayer(), transition: Transition.downToUp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          child: playerController.playingMusic["poster"].isEmpty
                              ? Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTextColor),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: '${playerController.playingMusic["poster"]}',
                              placeholder: (c, s) => Image.asset("assets/placeholder4.png"),
                              fit: BoxFit.contain,
                              height: 36,
                              width: 36,
                            ),
                          ),
                        ),
                        title: Text(
                          '${playerController.playingMusic["title"]}',
                          maxLines: 1,
                          style: fontMontserrat(
                            fontSize: 16,
                            color: kWhiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          '${playerController.playingMusic["artists"].join(", ")}',
                          maxLines: 1,
                          style: fontMontserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () => playerController.togglePlay(),
                          icon: Obx(() => Icon(
                            playerController.playing.value ? Icons.pause_circle : Icons.play_circle,
                            color: kPrimaryColor,
                          )),
                        ),
                      ),
                    ),
                  )
                      : const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}
