import 'package:get/get.dart';
import 'package:products/screens/splash_screen/controllers/SplashCubit.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashCubit>(() => SplashCubit());
  }
}
