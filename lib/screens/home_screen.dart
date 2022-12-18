import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nileur_music_app/Utils/common.dart';
import 'package:nileur_music_app/screens/equalizer_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nileur_music_app/screens/recentlyPlayed.dart';
import 'package:nileur_music_app/screens/search.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../Utils/collections.dart';
import '../controllers/home_controller.dart';
import '../controllers/player_controller.dart';
import '../widgets/custom_music_player.dart';
import 'categories.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: usersCollection.doc(controller.uid!).snapshots(),
          builder: (context, snapShots) {
            if (!snapShots.hasData) return customProgressIndicator();
            DocumentSnapshot udata = snapShots.data!;
            return Scaffold(
              backgroundColor: kBlackColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                      onTap: () => Get.to(const EqualizerScreen()),
                      child: Image.asset(
                        "assests/Frame 1.png",
                        height: 50,
                        width: 50,
                      )),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed("/profile",parameters: {"uid":controller.uid!});
                      },
                      icon: udata["profilePicture"].isEmpty
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assests/placeholderProfile.png"))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: udata["profilePicture"],
                                fit: BoxFit.cover,
                                height: 70,
                                width: 80,
                              ),
                            ))
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                children: [
                  Text(
                    'Good evening,',
                    style: fontMontserrat(
                      fontSize: 30,
                      letterSpacing: 2,
                      color: Color(0xffB7A3CF),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                   udata["name"],
                    style: fontMontserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onTap: ()=>Get.to(const Search()),
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade600.withAlpha(55),
                        hintStyle: fontMontserrat(
                          color: Color(0xffB7A3CF),
                        ),
                        hintText: 'Search songs, Artists,..',
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recently played',
                        style: fontMontserrat(color: Color(0xffB7A3CF), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                      GestureDetector(
                        onTap: ()=>Get.to(RecentlyPlayed(uid: controller.uid!)),
                        child: Text(
                          'More',
                          style: fontMontserrat(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 170,
                      child: StreamBuilder(
                        stream: usersCollection.doc(controller.uid!).collection("recentlyPlayed").limit(7).snapshots(),
                        builder: (context, snap) {
                          if (!snap.hasData) return const SizedBox.shrink();
                          List<DocumentSnapshot> recent = snap.data!.docs;
                          if (snap.hasData && recent.isEmpty) {
                            return SizedBox(
                              child: Text(
                                "No Recent Songs",
                                style: fontMontserrat(color: kTextColor),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: recent.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder(
                                    stream: musicCollections.doc(recent[index].id).snapshots(),
                                    builder: (context, mSnapShots) {
                                      if (!mSnapShots.hasData) return customProgressIndicator();
                                      DocumentSnapshot music = mSnapShots.data!;
                                      return playListCard(
                                        title: music["title"],
                                        subTitle: music["artist"].join(", "), poster: music["poster"], data: music,
                                      );
                                    });
                              });
                        },
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: fontMontserrat(color: Color(0xffB7A3CF), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                      Text(
                        'More',
                        style: fontMontserrat(
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
                    child: StreamBuilder(
                        stream: categoryCollections.where("active", isEqualTo: true).orderBy("name", descending: true).limit(7).snapshots(),
                        builder: (context, cSnap) {
                          if (!cSnap.hasData) return const SizedBox.shrink();
                          List<DocumentSnapshot> category = cSnap.data!.docs;
                          if (cSnap.hasData && category.isEmpty) {
                            return SizedBox(
                              child: Text(
                                "No Categories Found",
                                style: fontMontserrat(color: kTextColor),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: category.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: ()=>Get.to(()=>Categories(category: category[index]["name"],)),
                                  child: categoryCard(name: category[index]["name"]));
                            },
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Popular tracks',
                    style: fontMontserrat(color: Color(0xffB7A3CF), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PaginateFirestore(
                    onEmpty: const SizedBox.shrink(),
                    separator: const SizedBox(
                      height: 15,
                    ),
                    itemsPerPage: 10,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    isLive: true,
                    itemBuilderType: PaginateBuilderType.listView,
                    query: musicCollections.where("sort", arrayContains: "Popular track").orderBy("likesCount", descending: true),
                    itemBuilder: (context, documentSnapshots, index) {
                      DocumentSnapshot popular = documentSnapshots[index];
                      return trackCardList(
                        title: popular["title"],
                        artistName: popular["artist"].join(", "),
                        mid: popular.id,
                        poster: popular["poster"],
                        data: popular,
                      );
                    },
                  )
                ],
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
          }),
    );
  }
}

class trackCardList extends StatelessWidget {
  final String title, mid, poster;
  final String artistName;
  final DocumentSnapshot data;

  const trackCardList({super.key, required this.title, required this.artistName, required this.mid, required this.poster, required this.data});

  @override
  Widget build(BuildContext context) {
    var pController = Get.find<PlayerController>();
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                poster.isEmpty
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kTextColor),
                      )
                    : CachedNetworkImage(
                        imageUrl: poster,
                        fit: BoxFit.contain,
                        height: 50,
                        width: 50,
                      ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: fontMontserrat(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      artistName,
                      style: fontMontserrat(
                        color: kTextColor,
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
                  onPressed: () {
                    pController.initializePlayer(music: data);
                  },
                  icon: const Icon(
                    Icons.play_circle_filled_rounded,
                    size: 40,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.file_download_outlined,
                    size: 40,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
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
              style: fontMontserrat(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}

class playListCard extends StatelessWidget {
  final String title,poster;
  final String subTitle;
  final DocumentSnapshot data;

  const playListCard({super.key, required this.title, required this.subTitle, required this.poster, required this.data});

  @override
  Widget build(BuildContext context) {
    var pController = Get.find<PlayerController>();

    return Padding(
      padding: const EdgeInsets.only(
        right: 30,
      ),
      child: GestureDetector(
        onTap:()=>pController.initializePlayer(music: data) ,
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                
              ),
              child: poster.isEmpty?SizedBox.shrink():ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(imageUrl: poster,fit: BoxFit.cover,)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$title',
              style: fontMontserrat(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$subTitle',
              style: fontMontserrat(
                color: Color(0xffB7A3CF),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
