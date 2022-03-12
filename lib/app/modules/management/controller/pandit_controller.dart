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

