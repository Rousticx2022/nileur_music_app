import 'package:get/get.dart';
import 'package:nileur_music_app/controllers/login_controller.dart';
import 'package:nileur_music_app/controllers/profile_controller.dart';
import 'package:nileur_music_app/controllers/signup_controller.dart';

import '../controllers/home_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
class HomeBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(HomeController());
  }
}
class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}