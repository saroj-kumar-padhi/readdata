import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/resources/app_components/function_cards.dart';
import 'package:management/resources/app_components/menu_bar_tiles.dart';
import 'package:management/resources/app_exports.dart';

import '../../../../resources/app_strings.dart';

class AddUpdatePuja extends StatelessWidget{
  String tab = Get.parameters['tab']!;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       children: [
         Row(
           children: [
             Expanded(
               flex: 1,
               child: Padding(
                 padding: EdgeInsets.only(top: Get.height*0.2),
                 child: Column(
                   children: [
                    MenuBarTile(selectedTab: 'up', iconData: LineIcons.fileUpload, titleText: 'Update Puja',tab:tab,onTap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/up');},),
                    MenuBarTile(selectedTab: 'an', iconData: LineIcons.newspaper, titleText: 'Add New Puja',tab:tab ,onTap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/an');},),
                    MenuBarTile(selectedTab: 'rp', iconData: LineIcons.recycle, titleText: 'Remove Puja',tab:tab ,onTap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/rp');},),
                   ],
                 ),
               )),
             Expanded(
               flex: 4,
               child: Container(
                 margin: EdgeInsets.only(top: Get.height*.1),
                 child: StreamBuilder<QuerySnapshot>(
                   stream: FirebaseFirestore.instance.collection('/assets_folder/puja_ceremony_folder/folder').snapshots(),
                   builder: (context, snapshot) {
                     if(snapshot.data==null){
                       return const Center(child: CircularProgressIndicator(),);
                     }
                     List<Widget> _pujaCards = [];
                     snapshot.data!.docs.forEach((element) {
                       _pujaCards.add(PujaCards(text: element['puja_ceremony_name'][0], iconData: element['puja_ceremony_display_picture']));
                      });
                     return Wrap(
                       direction: Axis.horizontal,
                       children: _pujaCards,
                     );
                   }
                 )
               ),
             ),
           ],
         )
       ],
     ),
   );
  }

}