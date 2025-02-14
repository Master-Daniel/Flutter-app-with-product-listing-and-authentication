import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/widgets/apptext.dart';
import 'package:products/widgets/space.dart';
import 'package:products/utils/form_validator.dart';
import 'package:products/widgets/textfields.dart';
import 'package:products/widgets/app_elevated_button.dart';
import 'package:products/screens/register/controllers/RegisterCubit.dart';
import 'package:products/themes/colors.dart';

import 'package:get/get.dart';
import 'package:products/routes/app_pages.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!), backgroundColor: Colors.red),
              );
            } else if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.successMessage!), backgroundColor: Colors.green),
              );
            }
          },
          builder: (context, state) {
            final registerCubit = context.watch<RegisterCubit>();
            final _formKey = registerCubit.state.signUpFormKey;

            return Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vSpace(150),
                      MedAppText('Create Your Account', fontSize: 20, fontWeight: FontWeight.w600),
                      vSpace(20),
                      AppTextFormField(
                        label: 'Email Address',
                        hint: "eg jake******@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        controller: registerCubit.state.emailController,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.isValidEmail,
                      ),
                      vSpace(24),
                      AppTextFormField(
                        label: 'First Name',
                        hint: "eg James",
                        controller: registerCubit.state.firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: FormValidator.isValidFirstName,
                      ),
                      vSpace(24),
                      AppTextFormField(
                        label: 'Last Name',
                        hint: "eg Parker",
                        textInputAction: TextInputAction.next,
                        controller: registerCubit.state.lastNameController,
                        validator: FormValidator.isValidLastName,
                      ),
                      vSpace(24),
                      BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        return AppTextFormField(
                          label: 'Password',
                          controller: registerCubit.state.passwordController,
                          obscureText: !registerCubit.state.isPasswordVisible,
                          validator: FormValidator.isValidPassword,
                          hint: "*************",
                          suffixIcon: IconButton(
                            iconSize: 24,
                            icon: Icon(registerCubit.state.isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              registerCubit.togglePasswordVisibility();
                            },
                          ),
                        );
                      },
                    ),
                      vSpace(20),
                      AppElevatedButton(
                        child: state.isLoading ? CircularProgressIndicator(color: AppColors.white)
                            : MedAppText('Sign Up', color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            registerCubit.signUp();
                          }
                        },
                      ),
                      vSpace(20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.LOGIN);
                          }, // Handle navigation
                          child: MedAppText('Already have an account? Login', color: AppColors.primary),
                        ),
                      ),
                      vSpace(20),
                      Center(
                        child: TextButton(
                          onPressed: () {}, // Handle navigation
                          child: MedAppText('Continue as Guest', color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
