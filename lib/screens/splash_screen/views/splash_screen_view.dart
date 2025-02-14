import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/screens/splash_screen/controllers/SplashCubit.dart';
import 'package:products/themes/colors.dart';
import 'package:products/constants/images.dart';
import 'package:get/get.dart';
import 'package:products/routes/app_pages.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, bool>(
        listener: (context, isAuthenticated) {
          if (isAuthenticated) {
            Get.offNamed(Routes.PRODUCTS);
          } else {
            Get.offNamed(Routes.LOGIN);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: Image.asset(AppImages.logo, width: 194.5, height: 78.88),
          ),
        ),
      ),
    );
  }
}
