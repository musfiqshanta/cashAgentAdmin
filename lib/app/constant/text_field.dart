  import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:flutter/material.dart';

TextField textField(TextEditingController titleController) {
    return TextField(
            controller: titleController,
            style: TextStyle(color: white),

            decoration: InputDecoration(
              hintText: 'Notice Title',
              label: text(title: 'Notice Title'),
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