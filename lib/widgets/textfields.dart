import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products/themes/colors.dart';
import 'package:products/widgets/apptext.dart';
import 'package:products/widgets/space.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.obscureText = false,
    this.autoFocus = false,
    this.controller,
    this.focusNode,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  final bool obscureText;
  final bool autoFocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;

  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
          child: BigAppText(
            label ?? '',
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
        vSpace(10),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          onChanged: onChanged,
          textInputAction: textInputAction,
          autofocus: autoFocus,
          decoration: InputDecoration(
            isDense: true,
            focusColor: AppColors.primary,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.grey200), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.darkGrey,
            prefixIconColor: AppColors.darkGrey,
            hintText: hint,
            contentPadding: contentPadding,
            labelStyle: const TextStyle(color: AppColors.black), // Customize label text color
          ),
          style: const TextStyle(color: AppColors.black), // Customize text color
          cursorColor: AppColors.primary, // Customize cursor color
          validator: validator, // Use the provided validator function, or it will be null by default
        ),
      ],
    );
  }
}

class AppMultiTextFormField extends StatelessWidget {
  const AppMultiTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.minLines,
    this.maxLines,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;

  final int? minLines;
  final int? maxLines;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
          child: BigAppText(
            label ?? '',
            color: AppColors.black,
            fontSize: 14.sp,
          ),
        ),
        vSpace(10),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,

          controller: controller,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          maxLines: maxLines,
          onChanged: onChanged,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            focusColor: AppColors.blueGreen,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.blueGreen), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.grey), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.darkGrey,
            prefixIconColor: AppColors.darkGrey,
            hintText: hint,
            contentPadding: contentPadding,
            labelStyle: const TextStyle(
                color: AppColors.black), // Customize label text color
          ),
          style:
              const TextStyle(color: AppColors.black), // Customize text color
          cursorColor: AppColors.blueGreen, // Customize cursor color
          validator:
              validator, // Use the provided validator function, or it will be null by default
        ),
      ],
    );
  }
}
