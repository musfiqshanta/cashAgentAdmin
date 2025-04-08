import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:flutter/material.dart';

TextField textField({
  required TextEditingController titleController,
  required String hints,
  required String label,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: titleController,
    style: TextStyle(color: white),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hints,
      label: text(title: label),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: gray),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: gray),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
