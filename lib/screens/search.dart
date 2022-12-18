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

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  String searchText = "";
  var pController = Get.find<PlayerController>();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: TextFormField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchText = value.toLowerCase();
            });
          },
          style: fontMontserrat(color: kTextColor),
          decoration: InputDecoration(
            fillColor: kWhiteColor.withOpacity(.1),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
            hintStyle: const TextStyle(fontSize: 16, color: kTextColor),
            hintText: "Search music,songs...",
          ),
        ),
      ),
      body: searchText.isEmpty
          ? const SizedBox.shrink()
          : StreamBuilder(
              stream: musicCollections.snapshots(),
              builder: (context, mSnap) {
                if (!mSnap.hasData) return customProgressIndicator();
                List<DocumentSnapshot> music = mSnap.data!.docs;
                if (searchText.isNotEmpty) {
                  music = music.where((element) => element["title"].contains(RegExp(searchText, caseSensitive: false))).toList();
                }

                return ListView.builder(
                    itemCount: music.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: music[index]["poster"].isEmpty
                            ? Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTextColor),
                              )
                            : CachedNetworkImage(
                                imageUrl: music[index]["poster"],
                                fit: BoxFit.contain,
                                height: 50,
                                width: 50,
                              ),
                        title: Text(
                          music[index]["title"],
                          style: fontMontserrat(color: kWhiteColor),
                        ),
                        subtitle: Text(
                          music[index]["artist"].join(","),
                          style: fontMontserrat(color: kTextColor),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            pController.initializePlayer(music: music[index]);
                          },
                          icon: Obx(() => Icon(
                                pController.playing.value ? Remix.pause_circle_fill : Remix.play_circle_fill,
                                size: 40,
                                color: kPrimaryColor,
                              )),
                        ),
                      );
                    });
              }),
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
