import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:products/screens/splash_screen/controllers/SplashCubit.dart';
import 'package:products/screens/register/controllers/RegisterCubit.dart';
import 'package:products/screens/login/controllers/LoginCubit.dart';

import 'package:products/screens/splash_screen/views/splash_screen_view.dart';
import 'package:products/screens/register/views/register_view.dart';
import 'package:products/screens/login/views/login_view.dart';
import 'package:products/screens/products/views/products_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.PRODUCTS;

  static final routes = [
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => BlocProvider(
        create: (context) => SplashCubit(),
        child: ProductScreenView(),
      ),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => BlocProvider(
        create: (context) => SplashCubit(),
        child: const SplashScreenView(),
      ),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginView(),
      ),
    ),
    // GetPage(
    //   name: _Paths.PRODUCTS_DETAILS,
    //   page: () => const WelcomeView(),
    //   binding: WelcomeBinding(),
    // ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => BlocProvider(
        create: (context) => RegisterCubit(),
        child: const RegisterView(),
      ),
    ),
  ];
}
