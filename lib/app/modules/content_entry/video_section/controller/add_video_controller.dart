import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:management/resources/app_exports.dart';

class AddVideoController extends GetxController{
  var addVideoData = AddVideoData(image: 'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png').obs;
  updateImage(String imgUrl){
    addVideoData.update((val) {
      val!.image = imgUrl;
    });
  }

}

class AddVideoData{
  String image;
  AddVideoData({required this.image});
}
