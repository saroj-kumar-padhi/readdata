import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReadData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("read data"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  stream: FirebaseFirestore.instance.collection('RBOOKING').snapshots(),
  builder: (_, snapshot) {
    if (snapshot.hasError) return Text('Error = ${snapshot.error}');

    if (snapshot.hasData) {
      final docs = snapshot.data!.docs;
      return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (_, i) {
          final data = docs[i].data();
          return ListTile(
            title: Text(data['client']),
            subtitle: Text(data['email']),
          );
        },
      );
    }

    return Center(child: CircularProgressIndicator());
  },
),
    );
//       body: 
//       StreamBuilder<List<User>>(
//         stream: 
//         readUser(),
//         builder: (context,snapshort){
          
//           if (snapshort.hasData) {
//             final users = snapshort.data!;
//             return
//              ListView(children: users.map(buildUser).toList(),);
            
//           } else {
//             return Center(child: const CircularProgressIndicator());
//           }

//         },
//         ),
      
      
//     );
//   }
// }

// Widget buildUser(User user) => ListTile(
//   leading: CircleAvatar(child: Text('S')),
//   title: Text(user.name),
//   subtitle: Text(user.status),

// );

// class User {
//   final String bookingId;
//   final String name;
//   final String status;
//   final String location;
//   final int  due;

//    User({this.bookingId= "",
//   required this.name,
//   required this.status,
//   required this.location,
//   required this.due,
//   });

//   User.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         bookingId = json['bookingId'],
//         status = json['status'],
//         location = json['location'],
//         due = json['due'];

//   // Map<String, dynamic> toJson() => {
//   //       'name': name,
//   //       'email': email,
//   //     };
// }

// Stream<List<User>> readUser() => FirebaseFirestore.instance.collection('RBOOKING')
//       .snapshots()
//      .map((snapshort) =>
//       snapshort.docs.map((doc) => User.fromJson(doc.data())).toList());

  }
}