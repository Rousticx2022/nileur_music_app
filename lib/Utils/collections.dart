import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection =
FirebaseFirestore.instance.collection("users");
CollectionReference musicCollections =
FirebaseFirestore.instance.collection("music");
CollectionReference musicDataCollections =
FirebaseFirestore.instance.collection("musicData");
CollectionReference categoryCollections =
FirebaseFirestore.instance.collection("categories");
