import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../resources/app_exports.dart';
import '../models/pandit_users_model.dart';

class PanditSettingController extends GetxController{
  final AsyncSnapshot<DocumentSnapshot> query;
  PanditSettingController({required this.query});

   @override
  void onInit() {
    super.onInit();
    updatePanditData(query.data!['pandit_verification_status'], query.data!['pandit_name'], 
    query.data!['pandit_bio'], query.data!['pandit_qualification'], query.data!['pandit_mobile_number'], query.data!['pandit_experience'],
    query.data!['pandit_state'], query.data!['pandit_city'],query.data!['pandit_email']) ;
  }

  var panditData = PanditSettingData(verification: false, edit: false ).obs;

  updatePanditData(bool verification, String name, String bio, dynamic qualification,String number,String experience,String state ,String city,dynamic email){

    panditData.update((val) {
      val!.number = number;
      val.name = name;
      val.bio = bio;
      val.qualification = qualification;
      val.exp = experience;
      val.number =  number;
      val.city = city;
      val.email = email;
    });

  }
  updateVerification(bool verify){
    panditData.update((val) {
      val!.verification = verify;
    });
  }
}

class PanditServiesController extends GetxController{
  final Rx<List<Map<String, dynamic>>> allPujas =  Rx<List<Map<String, dynamic>>>([]);
  var panditServiceData  = PanditServiceData(add: false).obs;
  Future<void> samagriFetch() async {
    await FirebaseFirestore.instance
        .collection("assets_folder/puja_ceremony_folder/folder")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allPujas.value.add({
          "id": element.id,
          "name": element['puja_ceremony_name'][0],
          "selected": false,
          "duration": "duration",
          "price":"price",
        });
      });
    });
  }
}

class PanditServiceData{
  bool add;
  PanditServiceData({required this.add});
}

