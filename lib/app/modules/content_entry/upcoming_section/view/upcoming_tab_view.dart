import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/app/modules/content_entry/puja_view/controller/puja_add_controller.dart';
import 'package:management/app/modules/content_entry/puja_view/views/update_puja.dart';
import 'package:management/app/modules/content_entry/upcoming_section/view/add_upcoming_view.dart';
import 'package:management/resources/app_components/function_cards.dart';
import 'package:management/resources/app_components/menu_bar_tiles.dart';
import 'package:management/resources/app_exports.dart';
import '../../../../../resources/app_strings.dart';
import '../../puja_view/views/add_new_puja.dart';


class UpcomingTab extends StatelessWidget {
  String tab = Get.parameters['tab']!;

  UpcomingTab({Key? key}) : super(key: key);
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
                    padding: EdgeInsets.only(top: Get.height * 0.2),
                    child: Column(
                      children: [
                        MenuBarTile(
                          selectedTab: 'up',
                          iconData: LineIcons.fileUpload,
                          titleText: 'Update Upcoming',
                          tab: tab,
                          onTap: () {
                            Get.toNamed(
                                '/home/${AppStrings.CONTENT_ENTRY}/upcoming/up');
                          },
                        ),
                        MenuBarTile(
                          selectedTab: 'an',
                          iconData: LineIcons.newspaper,
                          titleText: 'Add Upcoming',
                          tab: tab,
                          onTap: () {
                            Get.toNamed(
                                '/home/${AppStrings.CONTENT_ENTRY}/upcoming/an');
                          },
                        ),
                        MenuBarTile(
                          selectedTab: 'rp',
                          iconData: LineIcons.recycle,
                          titleText: 'Remove Upcoming',
                          tab: tab,
                          onTap: () {
                            Get.toNamed(
                                '/home/${AppStrings.CONTENT_ENTRY}/upcoming/rp');
                          },
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Container(
                    margin: EdgeInsets.only(top: Get.height * .1),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                'PujaPurohitFiles/commonCollections/upcoming')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<Widget> _pujaCards = [];
                          snapshot.data!.docs.forEach((element) {
                            _pujaCards.add(PujaCards(  
                            remove: tab=='rp'?true:false,                           
                            text: element['name'],
                            deleteOntap: (){
                              print("delete called");
                              FirebaseFirestore.instance.doc('PujaPurohitFiles/commonCollections/upcoming/${element.id}').delete();
                            },
                            iconData:
                                element['image'],
                            ontap: () {
                              
                            },
                            ));
                          });
                          if (tab == 'up' || tab == 'rp') {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Wrap(                              
                                direction: Axis.horizontal,
                                children: _pujaCards,
                              ),
                            );
                          } else if (tab == 'an') {
                            return AddUpcomingView();
                          }
                          return SizedBox();
                        })),
              ),
            ],
          )
        ],
      ),
    );
  }
}
