import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/app/modules/content_entry/video_section/add_video.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

import '../../../../../resources/app_exports.dart';
import '../../../../../resources/responshive.dart';
import 'controller/add_video_controller.dart';

class UpdateVideo extends StatefulWidget {
  final String language;
  final String puja_key;
  final String  puja_name;
  final  String title;
  final String video_id;
  final String  video_thumbnail;
  final  String live;
  final String image;
  final String eventId;
  const UpdateVideo({Key? key,required this.language,required this.puja_key, required this.puja_name,required this.title, required this.live, required this.video_id,required this.video_thumbnail,required this.image,required this.eventId,}) : super(key: key);
  @override
  State<UpdateVideo> createState() => _UpdateVideoState();
}


class _UpdateVideoState extends State<UpdateVideo> {
  String image2 =
      'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png';
  AddVideoController controller = Get.put(AddVideoController());

  @override
  Widget build(BuildContext context) {
    TextEditingController language = TextEditingController(text:"${widget.language}");
    TextEditingController puja_key = TextEditingController(text:widget.puja_key);
    TextEditingController puja_name = TextEditingController(text:widget.puja_name);
    TextEditingController tittle = TextEditingController(text:widget.title);
    TextEditingController video_id = TextEditingController(text:widget.video_id);
    TextEditingController video_thumbnail = TextEditingController(text:widget.video_thumbnail);
    TextEditingController live = TextEditingController(text:widget.live);
    TextEditingController channel_logo = TextEditingController(text:widget.image);
    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? const EdgeInsets.all(0)
          : EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.07),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  addCustomTextField(channel_logo, 'Channel Logo(link)'),
                  addCustomTextField(language, 'Language number'),
                  addCustomTextField(puja_key, 'Puja Key'),
                  addCustomTextField(puja_name, 'Puja Name'),
                  addCustomTextField(tittle, 'Title'),
                  addCustomTextField(video_id, 'Video Id'),
                  addCustomTextField(video_thumbnail, 'Video Thumbnail'),
                  addCustomTextField(live, 'Live (true or false)'),

                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(20),
                          title: "Warning",
                          content: Text("Are you sure you want to remove ?"),
                          onConfirm: () {
                            Future.delayed(Duration(seconds: 4), () async{

                              await FirebaseFirestore.instance
                                  .doc(
                                  '/PujaPurohitFiles/all_videos/videos/${video_id.text.trim()}')
                                  .update({

                                'language' : int. parse(language.text.trim()) ,
                                'puja_key' : puja_key.text.trim(),
                                'channel_logo' : channel_logo.text.trim(),
                                'puja_name' : puja_name.text.trim(),
                                'tittle' :tittle.text.trim(),
                                'video_id' :video_id.text.trim(),
                                'video_thumbnail':video_thumbnail.text.trim(),
                                "live":live.text.trim(),
                                "timetamp":FieldValue.serverTimestamp(),
                              });

                              await FirebaseFirestore.instance
                                  .doc(
                                  '/puja_purohit_tv/live_aarti/${video_id.text.trim()}')
                                  .update({

                                'language' : int. parse(language.text.trim()) ,
                                'puja_key' : puja_key.text.trim(),
                                'channel_logo' : channel_logo.text.trim(),
                                'puja_name' : puja_name.text.trim(),
                                'tittle' :tittle.text.trim(),
                                'video_id' :video_id.text.trim(),
                                'video_thumbnail':video_thumbnail.text.trim(),
                                "live":live.text.trim(),
                                "timetamp":FieldValue.serverTimestamp(),
                              });

                            });
                          },
                          onCancel: () {
                            Get.back();
                          });
                    },
                    child: redButton("Submit"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container redButton(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red, width: 2.0)),
      child: Text(text),
    );
  }}

//   Widget addEventTextField(TextEditingController controller, hintText) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: TextFormField(
//           keyboardType: TextInputType.multiline,
//           maxLines: 10,
//           minLines: 1,
//           controller: controller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.blue, width: 1.0),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             fillColor: Colors.grey,
//
//             hintText: hintText,
//
//             //make hint text
//             hintStyle: const  TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//
//             //create lable
//             labelText: hintText,
//             //lable style
//             labelStyle: const TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//           )),
//     );
//   }
// }

