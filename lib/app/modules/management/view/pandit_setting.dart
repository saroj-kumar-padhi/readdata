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
              showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure you want to delete ?"),
      content: Text("Pandit Name : ${query.data!['pandit_name']}\nYour id will be captured"),
      actions: <Widget>[
         TextButton(
          child: new Text("OK"),
          onPressed: () async{
           await FirebaseFirestore.instance.doc(query.data!['pandit_uid']).delete();
           Navigator.pop(context);
           
           
          },
        ),
      ],
    );
  },
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