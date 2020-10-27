import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';

class CustomTextTheme with ChangeNotifier {
  static final bigText1 = TextStyle(
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w700,
    fontSize: 88.sp,
    color: AppColors.primaryColor,
  );
  static final bigText2 = TextStyle(
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w700,
    fontSize: 130.sp,
    color: AppColors.primaryColor,
  );
  static final smallBold = TextStyle(
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w700,
    fontSize: 33.sp,
    color: AppColors.primaryColor,
  );
  static final subtitle1 = TextStyle(
    fontFamily: 'Metropolis',
    fontSize: 38.sp,
    color: AppColors.primaryColor,
  );
  static final subtitle2 = TextStyle(
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w700,
    fontSize: 38.sp,
    color: AppColors.primaryColor,
  );
  static final subtitle3 = TextStyle(
    fontFamily: 'Metropolis',
    fontSize: 33.sp,
    color: AppColors.primaryColor,
  );
  static final smallNames = TextStyle(
    fontFamily: 'Metropolis Light',
    fontStyle: FontStyle.italic,
    fontSize: 38.sp,
    color: AppColors.primaryColor,
  );
  static final title = TextStyle(
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w500,
    fontSize: 70.sp,
    letterSpacing: 3,
    color: Color(0xff555555),
  );
  static final textFieldHint = TextStyle(
    fontFamily: 'Metropolis Light',
    fontStyle: FontStyle.italic,
    fontSize: 50.sp,
    color: AppColors.primaryColor,
  );
  static final textField = TextStyle(
    fontFamily: 'Metropolis',
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    fontSize: 50.sp,
    color: AppColors.primaryColor,
  );
}
