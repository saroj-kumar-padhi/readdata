import 'package:flutter/material.dart';
import 'package:management/resources/app_exports.dart';



class AddUpdateDetailController extends GetxController{
  var detailData = AddUpdateDetailData().obs;
  List<Widget> form = <Widget>[].obs;
  List<TextEditingController> paragraph= <TextEditingController>[].obs;
  RxInt textControllerIndex = 0.obs;
  RxList<Map<String, dynamic>>? values;
  RxString image =
      'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png'.obs;
   @override

  RxBool loader = false.obs;

  updateLoader(){
   if(loader.value == true){
     loader.value = false;
   }
   else{
     loader.value = true;
   }
  }
  void onInit() {
    super.onInit();
    
  }


  addBlankText(){
    detailData.update((val) {
      val!.begin1 = List.generate(10, (index) => "");
      val.date1 = List.generate(10, (index) => "");
      val.end1 = List.generate(10, (index) => "");
      val.name1 = List.generate(10, (index) => "");
      val.vikram1 = List.generate(10, (index) => "");
    });
  }

}

class AddUpdateDetailData{
  String? begin;
  List<String>? begin1;
  String? date;
  List<String>? date1;
  String? end;
  List<String>? end1;
  String? name;
  List<String>? name1;
  String? vikram;
  List<String>? vikram1;
  AddUpdateDetailData({this.begin,this.begin1,this.date,this.date1,this.end,this.end1,this.name,this.name1,this.vikram,this.vikram1});
}