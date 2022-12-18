import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import '../Utils/collections.dart';

class PlayerController extends GetxController with GetSingleTickerProviderStateMixin {
  String uid = "";
  final AudioPlayer player = AudioPlayer();
  RxMap playingMusic = {}.obs;
  RxBool playerInitialized = false.obs, playing = false.obs, volume = true.obs;
  late AnimationController rotationController;

  initializePlayer({required DocumentSnapshot music}) async {
    playingMusic.value = {
      "id": music.id,
      "title": music["title"],
      "poster": music["poster"],
      "artists": music["artist"],
    };
    await player.setUrl(music["audio"]);
    playerInitialized.value = true;
    playing.value = true;
    player.play();
    rotationController.forward();

    await usersCollection.doc(uid).collection("recentlyPlayed").doc(music.id).get().then((value) async {
      if (value.exists) {
        usersCollection.doc(uid).collection("recentlyPlayed").doc(music.id).update({
          "lastPlayed": DateTime.now(),
          "playedTimes": FieldValue.increment(1),
        });
      } else {
        usersCollection.doc(uid).collection("recentlyPlayed").doc(music.id).set({
          "lastPlayed": DateTime.now(),
          "playedTimes": 1,
        });
      }
    });
  }

  togglePlay() async {
    if (player.playing) {
      playing.value = false;
      await player.pause();
      rotationController.stop();
    } else {
      playing.value = true;
      await player.play();
      rotationController.forward();
    }
  }

  toggleVolume() async {
    if (player.volume == 0.0) {
      volume.value = true;
      await player.setVolume(1.0);
    } else {
      volume.value = false;
      await player.setVolume(0.0);
    }
  }

  seekNext() async {
    await player.seekToNext();
  }
  seekPrevious() async {
    await player.seekToPrevious();
  }


  seekForward() async {
    await player.seek(Duration(seconds: player.position.inSeconds + 10));
  }

  seekReverse() async {
    await player.seek(Duration(seconds: player.position.inSeconds - 10));
  }

  seekRepeat() async {
    await player.setLoopMode(LoopMode.all);
  }
  seekRepeatRelease() async {
    await player.setLoopMode(LoopMode.off);
  }

  seekShuffle() async {
    await player.setShuffleModeEnabled(true);
  }

  /* queueList({required DocumentSnapshot music}) async{
   PaginateFirestore(
     query: playlistsCollection.where("followers",arrayContains :uid).orderBy('followersCount'),
     itemBuilderType:PaginateBuilderType.listView,
     itemBuilder: (context, documentSnapshots, index) {
       DocumentSnapshot playlist = documentSnapshots[index];

       return StreamBuilder(
           stream: playlistsCollection.where("musics",arrayContains: music.id).snapshots(),
           builder:  (context, snapshot) {
             return StreamBuilder(
                 stream: musicsCollection.snapshots(),
                 builder:(context, snapshot) {
                   return Container();
                 } );

           });



     },


   )
  }*/


  @override
  void onInit() {
    volume.value = player.volume == 0.0 ? false : true;
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    rotationController.addListener(() {
      if (rotationController.status == AnimationStatus.completed) {
        rotationController.repeat();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    rotationController.dispose();
    player.dispose();
  }
}