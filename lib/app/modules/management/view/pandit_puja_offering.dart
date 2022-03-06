import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PujaOffering extends StatelessWidget{
  final AsyncSnapshot<DocumentSnapshot> asyncSnapshot;
 const PujaOffering({required this.asyncSnapshot});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection(
                                      '/users_folder/folder/pandit_users/${asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final data = snapshot.data!.docs;
                                    List<Widget> pooja = [];
                                    for (var mess in data) {
                                      final String? name = mess['puja_ceremony_keyword'];
                                      final String? keyword = mess['keyword'];
                                      final double? price = mess['puja_ceremony_price'];
                                      final String? duration = mess['puja_ceremony_time'];                                      
                                      final String? id = mess['puja_ceremony_id'];
                                      final subscriber = mess['puja_ceremony_subscriber'];
                                      final messagewidget = pujaoffering(
                                          name,
                                          keyword,
                                          price,
                                          duration,                                          
                                          subscriber,id);
                                      pooja.add(messagewidget);
                                    }
                                    return ListView(
                                      children: pooja,
                                      shrinkWrap: true,
                                    );
                                  });
  }
  Widget pujaoffering(name, keyword, price, duration,subscriber,id) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            child: Text(
              '$subscriber',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          title: Text(
            '$name',
            style:GoogleFonts.aBeeZee(color: Colors.black54,fontSize: 14, fontWeight: FontWeight.bold),
          ),
          trailing: Text('\₹ $price', style: TextStyle(fontSize: 12)),
          subtitle: Text('$duration', style: TextStyle(fontSize: 12)),
        ),
        SizedBox(height:20),
        Row(
          children: [
    
          ],
        )
      ],
    );
  }


}

