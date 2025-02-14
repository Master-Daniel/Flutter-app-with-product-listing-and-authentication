import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:products/screens/login/controllers/LoginCubit.dart';
import 'package:products/screens/products/controllers/ProductsCubit.dart';
import 'package:products/screens/splash_screen/bindings/splash_screen_binding.dart';
import 'package:products/screens/products/services/products_service.dart';
import 'routes/app_pages.dart';
import 'themes/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit(ProductService())),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        splitScreenMode: true,
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.SPLASH_SCREEN,
            initialBinding: SplashScreenBinding(),
            getPages: AppPages.routes,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              dialogBackgroundColor: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}

