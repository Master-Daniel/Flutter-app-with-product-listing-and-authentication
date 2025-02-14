import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:products/widgets/app_elevated_button.dart';
import 'package:products/widgets/apptext.dart';
import 'package:products/widgets/space.dart';
import 'package:iconsax/iconsax.dart';

import '../themes/colors.dart';
import 'bottomsheet_handlebar.dart';

class UiService {
  Future showInfoDialog(
      {required Widget content, bool barrierDismissible = true}) async {
    return await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      radius: 10,
      barrierDismissible: barrierDismissible,
      content: SizedBox(
        width: 343.w,
        child: content,
      ),
    );
  }

  Future showLocationDisclosure({
    required void Function()? onAccept,
    required void Function()? onReject,
  }) async {
    return await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      radius: 10,
      barrierDismissible: false,
      content: SizedBox(
        width: 343.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BigAppText('Location Disclosure'),
            vSpace(10),
            SmallAppText(
              "This app utilizes your device's location to find nearby couriers for efficient service. Your location data is solely employed within the app and won't be shared without your explicit consent. You can control location settings within the app or your device settings. For further information, please refer to our Privacy Policy or contact us directly.",
            ),
            vSpace(20),
            Row(
              children: [
                Visibility(
                  visible: Platform.isAndroid,
                  child: Expanded(
                    child: AppOutlinedButton(
                      title: Platform.isAndroid ? 'Reject' : 'Cancel',
                      onPressed: onReject,
                    ),
                  ),
                ),
                Visibility(
                  visible: Platform.isAndroid,
                  child: hSpace(20),
                ),
                Expanded(
                  child: AppElevatedButton(
                    title: Platform.isAndroid ? 'Accept' : 'Continue',
                    onPressed: onAccept,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future showInfoDialogString(
      {required String data, bool barrierDismissible = true}) async {
    return await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      radius: 10,
      barrierDismissible: barrierDismissible,
      content: SizedBox(
        width: 343.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.info_circle,
              color: AppColors.blueGreen,
              size: 50.r,
            ),
            Center(
              child: MedAppText(
                data,
                alignment: TextAlign.center,
                fontSize: 14.sp,
              ),
            ),
            vSpace(20),
            TextButton(
              onPressed: () => Get.back(),
              child: SmallAppText(
                'OK',
              ),
            )
          ],
        ),
      ),
    );
  }

  Future showLoadingDialog() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (builder) {
        return const Center(
          child: SpinKitRipple(
            color: AppColors.blueGreen,
            size: 70,
          ),
        );
      },
    );
  }

  Future showLoadingDialogWithMessage(String message) async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (builder) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitRipple(
              color: AppColors.blueGreen,
              size: 70,
            ),
            vSpace(5),
            SmallAppText(
              message,
              color: AppColors.white,
            ),
          ],
        );
      },
    );
  }

  Future showBottomSheet({
    String? title,
    String? description,
    bool isDismissible = true,
    required Widget content,
  }) async {
    return await Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHandlebar(),
            title != null
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: const TextStyle(),
                    ),
                  )
                : const SizedBox(),
            description != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      description,
                      style: const TextStyle(),
                    ),
                  )
                : const SizedBox(),
            content,
          ],
        ),
      ),
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  Future showBottomSheetWithDissmisibleOption({
    String? title,
    String? description,
    required bool isDismissible,
    required Widget content,
  }) async {
    return await Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHandlebar(),
            title != null
                ? Align(
                    alignment: Alignment.center,
                    child: BigAppText(title),
                  )
                : const SizedBox(),
            description != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SmallAppText(title ?? ''),
                  )
                : const SizedBox(),
            content,
          ],
        ),
      ),
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  Future showSuccessSnackBar({required String message}) async {
    Get.snackbar(
      'Success',
      message,
      borderColor: AppColors.blueGreen,
      borderWidth: 1,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(top: 10.h, left: 20, right: 20),
      backgroundColor: AppColors.blueGreen,
      colorText: Colors.white,
    );
  }

  Future showErrorSnackBar({required String message}) async {
    Get.snackbar(
      'Error',
      message,
      borderColor: AppColors.black,
      borderWidth: 1,
      borderRadius: 10,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(top: 10.h, left: 20, right: 20),
      backgroundColor: AppColors.red,
      colorText: Colors.white,
    );
  }
}
