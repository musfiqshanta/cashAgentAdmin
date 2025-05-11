import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/addNotice/views/add_notice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_notice_controller.dart';

class AddNoticeView extends GetView<AddNoticeController> {
  const AddNoticeView({super.key});
  @override
  Widget build(BuildContext context) {
    final notice = FirebaseFirestore.instance
        .collection('admin')
        .doc('notice')
        .collection('notices');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AddNotice(), transition: Transition.rightToLeft);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: notice.orderBy('time', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading;
          }
          final data = snapshot.data;
          return ListView.builder(
            itemCount: data!.docs.length,
            itemBuilder: (context, index) {
              // return Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: text(title: data.docs[index]['notice']),
              // );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      AddNotice(
                        title: data.docs[index]['notice'],
                        id: data.docs[index].id,
                      ),
                    );
                  },

                  tileColor: Get.theme.primaryColor,

                  title: text(title: data.docs[index]['notice']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
