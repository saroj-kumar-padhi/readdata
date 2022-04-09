import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/app/modules/content_entry/upcoming_section/controller/add_upcoming_controller.dart';
import 'package:management/resources/app_components/custom_widgets.dart';
import 'package:management/resources/app_exports.dart';

import 'controller/add_video_controller.dart';

class AddVideo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController language = TextEditingController();
    TextEditingController puja_key = TextEditingController();
    TextEditingController puja_name = TextEditingController();
    TextEditingController tittle = TextEditingController();
    TextEditingController video_id = TextEditingController();
    TextEditingController video_thumbnail = TextEditingController();
    TextEditingController live = TextEditingController();
    TextEditingController channel_logo = TextEditingController();
    TextEditingController god = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [

              addCustomTextField(channel_logo, 'Channel Logo(link)'),
              addCustomTextField(god, 'God'),
              addCustomTextField(language, 'Language number'),
              addCustomTextField(puja_key, 'Puja Key'),
              addCustomTextField(puja_name, 'Puja Name'),
              addCustomTextField(tittle, 'Title'),
              addCustomTextField(video_id, 'Video Id'),
              addCustomTextField(video_thumbnail, 'Video Thumbnail'),
              addCustomTextField(live, 'Live (true or false)'),

              SizedBox(height: 20,),
              InkWell(
                  onTap: (){
                    Get.defaultDialog(
                        middleText: "Are you sure you want to add ${tittle.text} as New video",
                        onConfirm: (){
                          if(language.text.isEmpty || puja_name.text.isEmpty || puja_key.text.isEmpty ||video_thumbnail.text.isEmpty || tittle.text.isEmpty || video_id.text.isEmpty){
                            Get.showSnackbar(const GetSnackBar(titleText: Text(''),messageText: Text('Please fill are fields properly'),duration: Duration(seconds: 2),));
                          }
                          else{

                            FirebaseFirestore.instance.doc('/PujaPurohitFiles/all_videos/videos/${video_id.text.trim()}').set({
                              'language' : language.text.trim() as int,
                              "channel_logo":channel_logo.text.trim(),
                              'puja_key' : puja_key.text.trim(),
                              'puja_name' : puja_name.text.trim(),
                              'tittle' :tittle.text.trim(),
                              'video_id' :video_id.text.trim(),
                              'video_thumbnail':video_thumbnail.text.trim(),
                              "live":live.text.trim(),
                              "timetamp":FieldValue.serverTimestamp(),
                            }).whenComplete(() {
                              Get.back();
                            });
                          }
                        },
                        onCancel: (){
                          Get.back();
                        }
                    );
                  },
                  child: redButton('Submit'))
            ],
          ),
        ),
    );
  }

}