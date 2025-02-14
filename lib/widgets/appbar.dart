import 'package:flutter/material.dart';

import 'package:products/themes/colors.dart';
import 'apptext.dart';

PreferredSizeWidget appBar(
    {required String title, Widget actionWidget = const SizedBox()}) {
  return AppBar(
    elevation: 0,
    
    foregroundColor: AppColors.black,
    backgroundColor: AppColors.white,
    title: MedAppText(
      title,
      fontSize: 20,
    ),
    centerTitle: true,
    actions: [actionWidget],
  );
}
