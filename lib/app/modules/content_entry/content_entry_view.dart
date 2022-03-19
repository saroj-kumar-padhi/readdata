import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_functions.dart';
import 'package:management/resources/app_strings.dart';
import '../../../resources/app_components/function_cards.dart';
import 'package:get/get.dart';
class ContentEntryView extends StatelessWidget{
  final String id;

  ContentEntryView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Wrap(
          children: [
          FunctionCards(iconData: CupertinoIcons.bolt_horizontal_circle ,text: 'Puja',ontap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/up');},),
          FunctionCards(iconData: CupertinoIcons.archivebox,text: 'Samagri',ontap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/samagri');},),
          FunctionCards(iconData: CupertinoIcons.calendar,text: 'Add Upcoming',ontap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/upcoming/up');},),
          FunctionCards(iconData: CupertinoIcons.device_laptop ,text: 'Change Banner',ontap:()async{          

          }),
          FunctionCards(iconData: CupertinoIcons.viewfinder ,text: 'Add Detail',ontap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/detail');},),

          ],
        )
      )
    );
  }

}

