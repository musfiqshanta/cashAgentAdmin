import 'package:cash_agent_admin/app/constant/button.dart';
import 'package:cash_agent_admin/app/constant/color.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/constant/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/options_controller.dart';

class OptionsView extends GetView<OptionsController> {
  const OptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    final options = FirebaseFirestore.instance.collection('admin').doc("urls");
    final optionsController = Get.put(OptionsController());
    return Scaffold(
      appBar: AppBar(title: const Text('OptionsView'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: options.get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return loading;
              }

              final data = snapshot.data;
              final contact = data!['contact'];
              final city = data['city'];
              final downloadUrl = data['downloadUrl'];
              final share = data['share'];
              final street = data['street'];
              final telegram = data['telegram'];
              final youtube = data['youtube'];

              final contactController = TextEditingController(text: contact);
              final cityController = TextEditingController(text: city);
              final downloadUrlController = TextEditingController(
                text: downloadUrl,
              );
              final shareController = TextEditingController(text: share);
              final streetController = TextEditingController(text: street);
              final telegramController = TextEditingController(text: telegram);
              final youtubeController = TextEditingController(text: youtube);

              return Column(
                spacing: 15,
                children: [
                  SizedBox(height: 15),
                  textField(
                    titleController: contactController,
                    hints: "Contact",
                    label: "Number",
                  ),
                  textField(
                    titleController: downloadUrlController,
                    hints: "Download Url",
                    label: "Download Url",
                  ),
                  textField(
                    titleController: youtubeController,
                    hints: "Youtube ",
                    label: "Youtube",
                  ),
                  textField(
                    titleController: telegramController,
                    hints: "Telegram ",
                    label: "Telegram",
                  ),

                  textField(
                    titleController: cityController,
                    hints: "City",
                    label: "City",
                  ),
                  textField(
                    titleController: streetController,
                    hints: "Street ",
                    label: "Street",
                  ),
                  textField(
                    titleController: shareController,
                    hints: "Share Text",
                    label: "Share Text",
                  ),
                  IconElevatedButton(
                    title: "Update",
                    icon: Icons.update,
                    color: green,
                    onPressed: () {
                      optionsController.updateOptions(
                        city: cityController.text,
                        contact: contactController.text,
                        downloadUrl: downloadUrlController.text,
                        share: shareController.text,
                        street: streetController.text,
                        telegram: telegramController.text,
                        youtube: youtubeController.text,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
