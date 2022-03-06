import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/resources/app_exports.dart';
import 'dart:html' as html;

class PujaOffering extends StatefulWidget{
  final AsyncSnapshot<DocumentSnapshot> asyncSnapshot;
 const PujaOffering({required this.asyncSnapshot});

  @override
  State<PujaOffering> createState() => _PujaOfferingState();
}

class _PujaOfferingState extends State<PujaOffering> {
  String enableId = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection(
                                      '/users_folder/folder/pandit_users/${widget.asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final data = snapshot.data!.docs;
                                    List<Widget> pooja = [];
                                    for (var mess in data) {
                                      print(mess['puja_ceremony_id']);
                                      final String? name = mess['puja_ceremony_keyword'];                                      
                                      final double? price = mess['puja_ceremony_price'];
                                      final String? duration = mess['puja_ceremony_time'];                                      
                                      final String? id = mess['puja_ceremony_id'];
                                      final subscriber = mess['puja_ceremony_subscriber'];
                                      final String? docId = mess.id;
                                      final messagewidget = pujaoffering(
                                          name,                                          
                                          price,
                                          duration,                                          
                                          subscriber,id,
                                          docId,
                                          );
                                      pooja.add(messagewidget);
                                    }
                                    return ListView(
                                      children: pooja,
                                      shrinkWrap: true,
                                    );
                                  });
  }

  Widget pujaoffering(name,price, duration,subscriber,pujaId,docId) {
    TextEditingController newPrice = TextEditingController(text: price.toString());
    TextEditingController newTime = TextEditingController(text: duration.toString());
    
    return Row(
      children: [
        SizedBox(
          width: Get.width*0.6,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Text(
                '$subscriber',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            title: Text(
              '$name',
              style:GoogleFonts.aBeeZee(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            trailing: SizedBox(
              width: 100,
              child: TextFormField(
                enabled: docId==enableId?true:false,
                controller: newPrice,
                style: const TextStyle(fontSize: 12,),
                decoration:const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(LineIcons.indianRupeeSign,size: 12,)
                ),
                ),
            ),
            subtitle: TextFormField(
              enabled: docId==enableId?true:false,
              controller: newTime,
              style: const TextStyle(fontSize: 12,),
              decoration:const InputDecoration(
                border: InputBorder.none,               
              ),
              ),
          ),
        ),
        const SizedBox(height:20),
        TextButton(onPressed: ()async{ 
         
          if(enableId==docId){
           await FirebaseFirestore.instance.doc('/users_folder/folder/pandit_users/${widget.asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services/$docId').update({
              'puja_ceremony_price':double.parse(newPrice.text),
              'puja_ceremony_time': newTime.text
            }).whenComplete((){
            setState(() {
              enableId = '';
            });
             html.window.location.reload();
            });
           
          }       
           else{
              setState(() {
              enableId = docId;
            });
           }
        }, child: Text(docId==enableId?"Save":"Edit", style: TextStyle(fontSize: 12,color: Get.isDarkMode?Colors.white:Colors.black87)))
      ],
    );
  }
}

