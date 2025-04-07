import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IconElevatedButton extends StatelessWidget {
  const IconElevatedButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.onPressed,
  });
  final String title;
  final IconData icon;
  final Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // Scaled border radius
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      ),
      icon: Icon(
        icon, // Your icon here
        size: 20.sp, // Scaled icon size
        color: white, // Icon color
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp, // Scaled font size
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ),
    );
  }
}

// class ElevatedButton extends StatelessWidget {
//   const ElevatedButton({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.color,
//     this.onPressed,
//   });
//   final String title;
//   final IconData icon;
//   final Color color;
//   final void Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color, // Button background color
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r), // Scaled border radius
//         ),
//         padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
//       ),
//       icon: Icon(
//         icon, // Your icon here
//         size: 20.sp, // Scaled icon size
//         color: white, // Icon color
//       ),
//       label: Text(
//         title,
//         style: TextStyle(
//           fontSize: 16.sp, // Scaled font size
//           fontWeight: FontWeight.bold,
//           color: white,
//         ),
//       ),
//     );
//   }
// }
