import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/helpers/database_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:products/routes/app_pages.dart';

// LoginState: Defines the state of the LoginCubit
class LoginState {
  final bool isPasswordVisible;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> loginFormKey;
  final Map<String, dynamic>? userData;

  LoginState({
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.userData,
    TextEditingController? loginController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? loginFormKey,
  })  : loginController = loginController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        loginFormKey = loginFormKey ?? GlobalKey<FormState>();

  // CopyWith: Helps update specific state properties
  LoginState copyWith({
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    Map<String, dynamic>? userData,
  }) {
    return LoginState(
      errorMessage: errorMessage,
      successMessage: successMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
      loginController: loginController,
      passwordController: passwordController,
      loginFormKey: loginFormKey,
    );
  }
}

// LoginCubit: Handles login logic
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState()) {
    loadUserSession(); // Load user session on initialization
  }

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final box = GetStorage();

  // Toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  // Login function
  Future<void> login() async {
    if (state.loginFormKey.currentState == null || !state.loginFormKey.currentState!.validate()) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, successMessage: null));

    try {
      final login = state.loginController.text.trim();
      final password = state.passwordController.text.trim();
      final user = await dbHelper.getUserByEmail(login);

      if (user != null && user['password'] == password) {
        // Save session data
        box.write('user', user);
        box.write('isLoggedIn', true);

        // Emit the new state with updated userData
        emit(state.copyWith(isLoading: false, successMessage: "Login Successful", userData: user));

        Future.delayed(Duration(milliseconds: 100), () {
          emit(LoginState(userData: user)); // Force a state update
          Get.offNamed(Routes.PRODUCTS);
        });
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: "Invalid login credentials"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Login Failed"));
    }
  }

  // Load user session
  void loadUserSession() {
    final user = box.read('user');
    if (user != null) {
      emit(state.copyWith(userData: user));
    }
  }

  // Logout function
  Future<void> logout() async {
    box.remove('user');
    box.remove('isLoggedIn');

    emit(state.copyWith(userData: null, successMessage: null, errorMessage: null));

    await Future.delayed(Duration(milliseconds: 50)); // Ensure delay is awaited
    emit(LoginState()); // Force update so AppDrawer rebuilds
    Get.offNamed(Routes.LOGIN);
  }

  @override
  Future<void> close() {
    state.loginController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
