import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text heading(
    {required String title, Color color = Colors.white, double size = 40}) {
  return Text(
    title,
    style: TextStyle(color: color, fontSize: size.sp),
  );
}

Text subheading(
    {required String title, Color color = Colors.white, double size = 28}) {
  return Text(
    title,
    style: TextStyle(color: color, fontSize: size.sp),
  );
}

Text text(
    {required String title,
    Color color = Colors.white,
    double size = 16,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    title,
    style: TextStyle(color: color, fontSize: size.sp, fontWeight: fontWeight),
  );
}
