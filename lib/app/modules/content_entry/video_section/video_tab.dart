import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/app/modules/content_entry/upcoming_section/view/add_upcoming_view.dart';
import 'package:management/app/modules/content_entry/upcoming_section/view/update_upcoming.dart';
import 'package:management/app/modules/content_entry/video_section/update_video.dart';
import 'package:management/resources/app_components/function_cards.dart';
import 'package:management/resources/app_components/menu_bar_tiles.dart';
import 'package:management/resources/app_exports.dart';
import '../../../../../resources/app_strings.dart';
import 'add_video.dart';



class VideoTab extends StatelessWidget {
  String tab = Get.parameters['tab']!;

  VideoTab({Key? key}) : super(key: key);
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
                          titleText: 'Update Video',
                          tab: tab,
                          onTap: () {
                            Get.toNamed(
                                '/home/${AppStrings.CONTENT_ENTRY}/video/up');
                          },
                        ),
                        MenuBarTile(
                          selectedTab: 'an',
                          iconData: LineIcons.newspaper,
                          titleText: 'Add Video',
                          tab: tab,
                          onTap: () {
                            Get.toNamed(
                                '/home/${AppStrings.CONTENT_ENTRY}/video/an');
                          },
                        ),
                        MenuBarTile(
                          selectedTab: 'rp',
                          iconData: LineIcons.recycle,
                          titleText: 'Remove Video',
                          tab: tab,
                          onTap: () {
                            Get.toNamed(
                                '/home/${AppStrings.CONTENT_ENTRY}/video/rp');
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
                            'PujaPurohitFiles/all_videos/videos')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<Widget> _videoCards = [];
                          snapshot.data!.docs.forEach((element) {
                            _videoCards.add(EventCards(
                              remove: tab=='rp'?true:false,
                              text: element["live"]=="false"?element['puja_name']:"${element['puja_name']}(live)",
                              deleteOntap: (){
                                print("delete called");
                                FirebaseFirestore.instance.doc('PujaPurohitFiles/all_videos/videos/${element.id}').delete();
                              },
                              iconData:
                              element['channel_logo'],
                              ontap: () {
                                //print(element["image"]);
                                //AddUpcomingController addUpcomingController =Get.put(AddUpcomingController());

                                Get.bottomSheet(
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      height: Get.height*0.9,
                                      child: UpdateVideo(
                                        eventId: element.id,
                                        image: element["channel_logo"],
                                        live: element["live"],
                                        title: element["tittle"],
                                        video_thumbnail: element["video_thumbnail"],
                                        puja_key: element["puja_key"],
                                        video_id: element["video_id"],
                                        language: element["language"],
                                        puja_name: element["puja_name"],
                                      ),
                                    ),
                                    backgroundColor: context.theme.backgroundColor,
                                    isScrollControlled: true
                                );

                              },
                            ));
                          });
                          if (tab == 'up' || tab == 'rp') {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: _videoCards,
                              ),
                            );
                          } else if (tab == 'an') {
                            return AddVideo();
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

