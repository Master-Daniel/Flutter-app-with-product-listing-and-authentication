import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<bool> {
  final box = GetStorage();

  AuthCubit() : super(false) {
    // Load saved auth state on startup
    emit(box.read('isAuthenticated') ?? false);
  }

  void login(String email, String password) {
    if (email == "test@example.com" && password == "password") {
      box.write('isAuthenticated', true);
      emit(true);
    } else {
      emit(false);
    }
  }

  void logout() {
    box.write('isAuthenticated', false);
    emit(false);
  }
}

