import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false) {
    checkAuthentication();
    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
  }

  void checkAuthentication() async {
    final box = GetStorage();
    final isLoggedIn = box.read('isLoggedIn') ?? false;

    await Future.delayed(Duration(seconds: 3)); // Simulate splash delay
    emit(isLoggedIn); // Emit true if logged in, false otherwise
  }
}

