import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';
import 'apptext.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
    //required String text,
    this.title,
    this.child,
  });
  final void Function()? onPressed;
  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: child ??
          SmallAppText(
            title ?? "",
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.child,
  });
  final void Function()? onPressed;
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1.0, color: AppColors.blueGreen),
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: child ??
          SmallAppText(
            title,
            color: AppColors.blueGreen,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
    );
  }
}
