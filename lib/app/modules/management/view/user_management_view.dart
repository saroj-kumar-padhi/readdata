import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_exports.dart';
import '../../../../resources/app_components/function_cards.dart';
import '../../../../resources/app_strings.dart';

class UserManagementView extends StatelessWidget{
  final String id;
  UserManagementView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Wrap(
          children: [
          FunctionCards(iconData: CupertinoIcons.person_circle ,text : 'User',ontap: (){ Get.toNamed('/home/${AppStrings.MANAGEMENT }/client_users');},),
          FunctionCards(iconData: CupertinoIcons.person_alt_circle ,text: 'Pandit',ontap: (){Get.toNamed('/home/${AppStrings.MANAGEMENT }/pandit_users');},),
          FunctionCards(iconData: CupertinoIcons.bell_circle ,text: 'Notification',ontap: (){},),
          FunctionCards(iconData: CupertinoIcons.money_dollar_circle ,text: 'Refund',ontap: (){},),
         

          ],
        )
      )
    );
  }

}

