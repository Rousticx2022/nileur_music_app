import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController{
  final box = GetStorage();
  String _uid = "";
  String get uid => _uid;
  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }
  checkAuth() {
    _uid = authenticate();
    // bool onboarded = box.read("onboarded") ?? false;
    Future.delayed(const Duration(seconds: 2), () async {
      if (_uid.isEmpty) {
        Get.offAllNamed("/login");
        return;
      }

      Get.offAllNamed("/home", parameters: {"uid": uid});
    });
  }
  String authenticate() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser == null ? "" : auth.currentUser!.uid;
  }
}