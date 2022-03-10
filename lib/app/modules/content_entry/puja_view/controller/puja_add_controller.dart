import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/app_exports.dart';

class HomeController extends GetxController {
  final List<Map<String,dynamic>> states = 
[{"code": "AN","name": "Andaman and Nicobar Islands"},
{"code": "AP","name": "Andhra Pradesh"},
{"code": "AR","name": "Arunachal Pradesh"},
{"code": "AS","name": "Assam"},
{"code": "BR","name": "Bihar"},
{"code": "CG","name": "Chandigarh"},
{"code": "CH","name": "Chhattisgarh"},
{"code": "DH","name": "Dadra and Nagar Haveli"},
{"code": "DD","name": "Daman and Diu"},
{"code": "DL","name": "Delhi"},
{"code": "GA","name": "Goa"},
{"code": "GJ","name": "Gujarat"},
{"code": "HR","name": "Haryana"},
{"code": "HP","name": "Himachal Pradesh"},
{"code": "JK","name": "Jammu and Kashmir"},
{"code": "JH","name": "Jharkhand"},
{"code": "KA","name": "Karnataka"},
{"code": "KL","name": "Kerala"},
{"code": "LD","name": "Lakshadweep"},
{"code": "MP","name": "Madhya Pradesh"},
{"code": "MH","name": "Maharashtra"},
{"code": "MN","name": "Manipur"},
{"code": "ML","name": "Meghalaya"},
{"code": "MZ","name": "Mizoram"},
{"code": "NL","name": "Nagaland"},
{"code": "OR","name": "Odisha"},
{"code": "PY","name": "Puducherry"},
{"code": "PB","name": "Punjab"},
{"code": "RJ","name": "Rajasthan"},
{"code": "SK","name": "Sikkim"},
{"code": "TN","name": "Tamil Nadu"},
{"code": "TS","name": "Telangana"},
{"code": "TR","name": "Tripura"},
{"code": "UK","name": "Uttarakhand"},
{"code": "UP","name": "Uttar Pradesh"},
{"code": "WB","name": "West Bengal"}];
  final List<Map<String, dynamic>> allSamagris = [];
  final Rx<List<Map<String, dynamic>>> foundPlayers =
  Rx<List<Map<String, dynamic>>>([]);
  RxList<String> selectedGodList = <String>[].obs;
  RxList<Widget> selectedGodListWidget = <Widget>[].obs;
  RxList<String> selectedBenefitList = <String>[].obs;
  RxList<Widget> selectedBeneditListWidget = <Widget>[].obs;
  RxString? keyword = ''.obs;
  RxString? price = ''.obs;
  RxString? duration = ''.obs;
  List<String> gods = [
    'god shiva',
    'god vishnu',
    'god laxmi',
    'god durga',
    'god kali',
    'god ganesh',
    'god anapurna',
    'god parwati',
  ];

  List<String> benefit = [
    'Hapiness',
    'Health',
    'Wealth',
  ];
  List<String> typeOfPuja = [
    'Puja for health',
    'Puja for wealth',
    'Puja for santi',
  ];
  RxString pujaType = 'Puja for health'.obs;

  @override
  void onInit() {
    super.onInit();
    samagriFetch();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> samagriFetch() async {
    await FirebaseFirestore.instance
        .collection("assets_folder/puja_items_folder/folder")
        .get()
        .then((value) {
      value.docs.forEach((element) {        
        allSamagris.add({
          "id" : element.id,
          "name": element['puja_item_name'][0],
          "selected": false,
          "quantity": 'quantity'
        });
      });
    }).whenComplete(() {
      foundPlayers.value = allSamagris;
    });
  }

  updateList() {
    foundPlayers.update((val) {
      val![1][''] = false;
    });
  }

  @override
  void onClose() {}
  void filterPlayer(String playerName) {
    List<Map<String, dynamic>> results = [];
    if (playerName.isEmpty) {
      results = allSamagris;
    } else {
      results = allSamagris
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    foundPlayers.value = results;
  }
}
