import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products/helpers/database_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:products/routes/app_pages.dart';

// 📌 Define the states
class RegisterState extends Equatable {
  final bool isLoading;
  final bool isPasswordVisible;
  final String? errorMessage;
  final String? successMessage;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> signUpFormKey;
  final Map<String, dynamic>? userData;

  const RegisterState({
    this.isPasswordVisible = false, 
    this.isLoading = false, 
    this.errorMessage, 
    this.successMessage, 
    this.userData,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.passwordController,
    required this.signUpFormKey
  });

  @override
  List<Object?> get props => [
    emailController, firstNameController, 
    lastNameController, passwordController, signUpFormKey, 
    isLoading, errorMessage, successMessage
  ];

  RegisterState copyWith({
    bool? isLoading, 
    String? errorMessage, 
    String? successMessage, 
    bool? isPasswordVisible,
    Map<String, dynamic>? userData,
    TextEditingController? emailController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? signUpFormKey,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      userData: userData ?? this.userData,
      emailController: emailController ?? this.emailController,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      passwordController: passwordController ?? this.passwordController,
      signUpFormKey: signUpFormKey ?? this.signUpFormKey,
    );
  }
}

// 📌 Cubit for Register Logic
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState(
    emailController: TextEditingController(),
    firstNameController: TextEditingController(),
    lastNameController: TextEditingController(),
    passwordController: TextEditingController(),
    signUpFormKey: GlobalKey<FormState>(),
  ));

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final box = GetStorage();

  // Toggle password visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> signUp() async {
    if (state.signUpFormKey.currentState == null || !state.signUpFormKey.currentState!.validate()) {
      return;
    }

    emit(state.copyWith(isLoading: false, errorMessage: null, successMessage: null));

    try {
      final email = state.emailController.text.trim();
      final userExists = await dbHelper.getUserByEmail(email);

      if (userExists != null) {
        emit(state.copyWith(isLoading: false, errorMessage: "Email already exists"));
        return;
      }

      final user = await dbHelper.insertUser({
        'email': email,
        'firstName': state.firstNameController.text.trim(),
        'lastName': state.lastNameController.text.trim(),
        'password': state.passwordController.text.trim(),
      });

      if (user != null) {
        box.write('user', user);
        box.write('isLoggedIn', true);

        emit(state.copyWith(isLoading: false, successMessage: "Registration Successful", userData: user));
        Get.offNamed(Routes.PRODUCTS);
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: "Failed to retrieve user data after registration"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Registration Failed"));
    }
  }

  @override
  Future<void> close() {
    state.emailController.dispose();
    state.firstNameController.dispose();
    state.lastNameController.dispose();
    state.passwordController.dispose();
    return super.close();
  }
}
