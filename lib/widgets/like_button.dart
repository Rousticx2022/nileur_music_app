import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nileur_music_app/Utils/common.dart';
import 'package:remixicon/remixicon.dart';

import '../Utils/collections.dart';

class LikeButton extends StatefulWidget {
  final String uid, musicID;
  const LikeButton({Key? key, required this.uid, required this.musicID}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: musicDataCollections.doc(widget.musicID).snapshots(),
        builder: (context, snapshot) {
          bool liked = false;
          if (!snapshot.hasData) {
            liked = false;
          }

          if (snapshot.hasData && snapshot.data!["likes"].contains(widget.uid)) {
            liked = true;
          }
          return IconButton(
            icon: Icon(liked ? Remix.heart_fill: Remix.heart_line, size: 30),
            color: kWhiteColor,
            onPressed: () async {
              await musicDataCollections.doc(widget.musicID).update({
                "likes": liked ? FieldValue.arrayRemove([widget.uid]) : FieldValue.arrayUnion([widget.uid]),
              });
            },
          );
        });
  }
}