import 'package:cash_agent_admin/app/constant/custom_text.dart';
import 'package:cash_agent_admin/app/constant/general_widget.dart';
import 'package:cash_agent_admin/app/modules/company/views/add_company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/company_controller.dart';

class CompanyView extends GetView<CompanyController> {
  const CompanyView({super.key});
  @override
  Widget build(BuildContext context) {
    final company = FirebaseFirestore.instance.collection('company');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company'),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              Get.to(AddCompany(), transition: Transition.rightToLeft);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: company.orderBy('index', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading;
          }
          final data = snapshot.data;
          return ListView.builder(
            itemCount: data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      AddCompany(
                        title: data.docs[index]['title'],
                        index: data.docs[index]['index'].toString(),
                        id: data.docs[index].id,
                      ),
                    );
                  },
                  tileColor: Get.theme.primaryColor,
                  onLongPress: () {
                    Get.snackbar('title', 'on long press');
                  },
                  leading: Image.asset('assets/img/innovation.png'),
                  title: text(title: data.docs[index]['title']),
                ),
              );
              // return Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: text(title: data.docs[index]['title']),
              // );
            },
          );
        },
      ),
    );
  }
}
