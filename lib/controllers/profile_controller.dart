import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nileur_music_app/controllers/player_controller.dart';

import '../Utils/collections.dart';
import '../Utils/common.dart';
import '../Utils/form_validators.dart';

class ProfileController extends GetxController {
  final String? uid = Get.parameters["uid"];
  final formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  var imageName = "", imageSize = 0, imagePath = "";
  var pController = Get.find<PlayerController>();
  TextEditingController nameController = TextEditingController();
  getUser() async {
    var doc = await usersCollection.doc(uid!).get();
    nameController.text = doc["name"];
  }

  void pickImage({bool gallery = false}) async {
    final XFile? image = await imagePicker.pickImage(source: gallery ? ImageSource.gallery : ImageSource.camera);
    if (image == null) return;
    imageSize = await image.length() ~/ 1000;
    if (imageSize > 5400) {
      customToast("Max file limit exceeds");
      return;
    }

    imageName = image.name;
    imagePath = image.path;
  }

  save() async {
    if (!formKey.currentState!.validate()) return;

    String imageURL = "";

    if (imagePath.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.ref();

      String ext = imagePath.split(".").last;
      int fileName = DateTime.now().millisecondsSinceEpoch;

      try {
        final postRef = storageRef.child("company/${uid!}/pp_$fileName.$ext");
        await postRef.putFile(File(imagePath));
        imageURL = await postRef.getDownloadURL();
      } on FirebaseException catch (e) {
        customToast(e.code);
      }
    }

    await usersCollection.doc(uid!).update({
      "profilePicture": imageURL,
      "name": nameController.text,
    });
    customToast("Profile edited");
    Get.back();
  }

  editProfile(DocumentSnapshot uData) {
    Get.bottomSheet(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: imagePath.isEmpty
                      ? CachedNetworkImage(
                          imageUrl: uData["profilePicture"],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        )
                      : Image.file(File(imagePath), width: 80, height: 80, fit: BoxFit.cover),
                ),
                GestureDetector(
                  onTap:()=>pickImage() ,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: kWhiteColor,width: .5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Edit Picture",style: fontMontserrat(color: kTextColor,fontSize: 18),),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nameController,
              style: fontMontserrat(color: kTextColor),
              decoration: InputDecoration(
                fillColor: kWhiteColor.withOpacity(.1),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                hintStyle: const TextStyle(fontSize: 16, color: kTextColor),
                hintText: "Enter UserName",
              ),
              validator: nameValidator,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, shape: const RoundedRectangleBorder()),
                onPressed: () => save(),
                child: Text(
                  "update",
                  style: fontMontserrat(color: kWhiteColor),
                ))
          ],
        ),
      ),
    ));
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
