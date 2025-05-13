import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loading = LoadingAnimationWidget.halfTriangleDot(
  color: Colors.black,
  size: 30,
);
SnackbarController snackBar(String title, des) {
  return Get.snackbar(title, des, backgroundColor: Colors.green);
}
