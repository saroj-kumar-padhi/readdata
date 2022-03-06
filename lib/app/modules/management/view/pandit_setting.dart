import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management/resources/app_exports.dart';
import 'package:switcher/switcher.dart';

class PanditSetting extends StatelessWidget{
  final AsyncSnapshot<DocumentSnapshot> query;
   PanditSetting({required this.query});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Verification',
            style: GoogleFonts.aBeeZee(color: Colors.black54),
          ),
          // StreamBuilder<DocumentSnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .doc('punditUsers/${query.data!['pandit_uid']}')
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.data == null) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       return Switcher(
          //         value: snapshot.data!['pandit_verification_status'],
          //         colorOn: Colors.orangeAccent,
          //         colorOff: Colors.grey,
          //         iconOn: Icons.verified,
          //         iconOff: Icons.remove_circle_outline,
          //         onChanged: (bool state) {
          //           FirebaseFirestore.instance
          //               .doc('punditUsers/${snapshot.data!['pandit_uid']}')
          //               .update({'pandit_verification_status': state});
          //           FirebaseFirestore.instance
          //               .doc(
          //                   'punditUsers/${snapshot.data!['uid']}/user_profile/user_data')
          //               .update({'pandit_verification_status': state});
          //         },
          //       );
          //     }),
        ],
      ),
      const Expanded(child: SizedBox()),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Get.defaultDialog(
                contentPadding: EdgeInsets.all(20),
                title: "Warning",
                content: Text("Are you sure you want to remove ${query.data!['pandit_name']} ?"),
                // confirm: Text("Confirm"),
                // cancel:  Text("Cancel"),
                onConfirm: (){
                  FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${query.data!['pandit_uid']}').delete();
                  Get.back();
                  Get.back();
                },
                onCancel: (){Get.back();}
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red,width: 2.0)
              ),
              child: Text("Delete Account"),
            ),
          )
        ],
      )
    ]);
  }

}