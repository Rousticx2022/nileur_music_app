import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/Utils/collections.dart';
import 'package:nileur_music_app/controllers/player_controller.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:remixicon/remixicon.dart';

import '../Utils/common.dart';
import '../widgets/custom_music_player.dart';

class Categories extends StatefulWidget {
  final String category;
  const Categories({Key? key, required this.category}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var pController = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          widget.category,
          style: fontMontserrat(color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),

      body: PaginateFirestore(
        onEmpty:  Text("No Songs in this category yet",style:fontMontserrat(),),
        itemsPerPage: 10,
        physics:const BouncingScrollPhysics(),
        shrinkWrap: true,
        isLive: true,
        query: musicCollections.where("category", arrayContains: widget.category).orderBy("likesCount"),
        itemBuilderType: PaginateBuilderType.listView,
        itemBuilder: (context, documentSnapshots, index) {
          DocumentSnapshot music = documentSnapshots[index];
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
            title: Text(
              music["title"],
              style: fontMontserrat(color: kWhiteColor),
            ),
            subtitle: Text(
              music["artist"].join(","),
              style: fontMontserrat(color: kTextColor),
            ),
            trailing: IconButton(
              onPressed: () {
                pController.initializePlayer(music: music);
              },
              icon: Obx(() => Icon(
                    pController.playing.value ? Remix.pause_circle_fill : Remix.play_circle_fill,
                    size: 40,
                    color: kPrimaryColor,
                  )),
            ),
          );
        },
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
    );
  }
}
