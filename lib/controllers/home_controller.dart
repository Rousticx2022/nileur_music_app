import 'package:get/get.dart';
import 'package:nileur_music_app/controllers/player_controller.dart';

class HomeController extends GetxController{
   String? uid=Get.parameters["uid"];

   @override
  void onInit() {
      PlayerController playerController = Get.put(PlayerController());
      playerController.uid = uid!;
    super.onInit();
  }

}