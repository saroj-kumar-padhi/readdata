import 'package:management/resources/app_exports.dart';

class Loader extends GetxController{
  RxBool loader = false.obs;

  updateLoader(){
   if(loader.value == true){
     loader.value = false;
   }
   else{
     loader.value = true;
   }
  }
}