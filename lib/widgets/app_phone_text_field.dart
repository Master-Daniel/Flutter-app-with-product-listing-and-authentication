import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:products/utils/app_logger.dart';
import 'package:products/utils/form_validator.dart';
import 'package:products/widgets/space.dart';
import 'package:products/themes/colors.dart';
import 'apptext.dart';

class PhoneNumberInputField extends StatelessWidget {
  const PhoneNumberInputField({super.key, this.controller, this.label, this.hint});
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
          child: SmallAppText(
            label ?? '',
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
        vSpace(5),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            //print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            //print(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            setSelectorButtonAsPrefixIcon: true,
            leadingPadding: 15,
          ),
          spaceBetweenSelectorAndTextField: 0,
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: const TextStyle(color: AppColors.black),
          initialValue: PhoneNumber(dialCode: '+234', isoCode: 'NG'),
          textFieldController: controller,
          formatInput: true,
          validator: (val) {
            return FormValidator.isValidPhoneNumber(val);
          },
          searchBoxDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.grey200), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.grey200, fontSize: 12.sp),
            labelStyle: const TextStyle(color: AppColors.black), // Customize label text color
          ),
          inputDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.grey200), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary), // Grey border
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.grey200, fontSize: 12.sp),
            labelStyle: const TextStyle(color: AppColors.black), // Customize label text color
          ),
          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
          inputBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.grey200), // Grey border
            borderRadius: BorderRadius.circular(10),
          ),
          onSaved: (PhoneNumber number) {
            appLog('On Saved: $number');
          },
        ),
      ],
    );
  }
}
