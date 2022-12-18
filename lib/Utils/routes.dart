import 'package:get/get.dart';
import 'package:nileur_music_app/screens/login_screen.dart';
import 'package:nileur_music_app/screens/signup_screen.dart';

import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/splash_screen.dart';
import 'bindings.dart';

class Pages {
  static List<GetPage> all = [
    GetPage(name: "/", page: () => const SplashScreen(), binding: SplashBinding()),
    GetPage(
      name: "/home",
      page: () => const HomeScreen(),binding: HomeBinding()
    ),
    GetPage(
      name: "/login",
      page: () => const LoginScreen(),binding: LoginBinding()
    ),
    GetPage(
      name: "/signup",
      page: () => const SignUpSCreen(),binding: SignUpBinding()
    ),
    GetPage(
        name: "/profile",
        page: () => const ProfileScreen(),binding: ProfileBinding()
    ),
  ];
}
