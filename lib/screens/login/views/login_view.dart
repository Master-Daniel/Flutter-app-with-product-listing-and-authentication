import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/routes/app_pages.dart';
import 'package:products/utils/app_logger.dart';
import 'package:products/utils/form_validator.dart';
import 'package:products/widgets/app_elevated_button.dart';
import 'package:products/widgets/space.dart';
import 'package:products/widgets/textfields.dart';
import 'package:products/themes/colors.dart';
import 'package:products/widgets/apptext.dart';
import 'package:products/screens/login/controllers/LoginCubit.dart';

import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red),
            );
          } else if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: Colors.green),
            );
          }
        }, builder: (context, state) {
          final loginCubit = context.watch<LoginCubit>();
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: loginCubit.state.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSpace(120),
                    Container(
                      width: 36.w,
                      height: 36.h,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.lightOrange,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 20.sp,
                            color: AppColors.primary,
                          ),
                          padding: simPad(0, 0),
                          constraints: const BoxConstraints(),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                    vSpace(20),
                    SmallAppText(
                      'Welcome Back!',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    vSpace(5),
                    MedAppText(
                      'Champ',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    vSpace(50),
                    MedAppText(
                      'Login Your Account',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    vSpace(20),
                    AppTextFormField(
                      label: 'Email Address',
                      hint: "eg jake******@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      controller: loginCubit.state.loginController,
                      textInputAction: TextInputAction.next,
                      validator: FormValidator.isValidEmail,
                    ),
                    vSpace(24),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return AppTextFormField(
                          label: 'Password',
                          controller: state.passwordController,
                          obscureText: !state.isPasswordVisible,
                          validator: FormValidator.isValidPassword,
                          hint: "*************",
                          suffixIcon: IconButton(
                            iconSize: 24,
                            icon: Icon(state.isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              loginCubit.togglePasswordVisibility();
                            },
                          ),
                        );
                      },
                    ),
                    vSpace(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero,
                          ),
                          minimumSize:
                              WidgetStateProperty.all(const Size(0, 0)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: MedAppText(
                          'Forgotten Password?',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    vSpace(20),
                    AppElevatedButton(
                        child: state.isLoading ? CircularProgressIndicator(color: AppColors.white)
                            : MedAppText('Log in', color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        onPressed: () {
                          if (loginCubit.state.loginFormKey.currentState!.validate()) {
                            loginCubit.login();
                          }
                        },
                      ),
                    vSpace(20),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MedAppText(
                                'Don\'t have an Account?',
                                fontWeight: FontWeight.w400,
                              ),
                              vSpace(5),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, Routes.REGISTER),
                                child: MedAppText(
                                  'Sign up',
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          vSpace(20),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, Routes.PRODUCTS),
                            child: MedAppText(
                              'Continue as Guest',
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
