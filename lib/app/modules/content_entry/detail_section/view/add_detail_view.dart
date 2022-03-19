import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

import '../../../../../resources/app_exports.dart';
import '../../../../../resources/app_functions.dart';
import '../controller/add_update_detail_controller.dart';

class AddUpdateDetailView extends StatelessWidget{

  AddUpdateDetailController addUpdateDetailController = Get.put(AddUpdateDetailController());
  
  @override
  Widget build(BuildContext context) {
    
      String imageId =
    "IMID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";
    
    return Scaffold(
      body: GetX<AddUpdateDetailController>(
        init: AddUpdateDetailController(), 
        initState: AddUpdateDetailController().addBlankText(),       
        builder: (controller) {
          TextEditingController name = TextEditingController();
          TextEditingController begin = TextEditingController();
          TextEditingController end = TextEditingController();
          TextEditingController date = TextEditingController();
          TextEditingController vikram = TextEditingController();
          TextEditingController pujaName = TextEditingController();
          TextEditingController  pujaKeyword = TextEditingController();
          TextEditingController videoId = TextEditingController();
          TextEditingController detailKeyword = TextEditingController();
          return  Padding(
            padding:  EdgeInsets.only(left:Get.width*0.05,right: Get.width*0.05,top: Get.height*0.05),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                          "Detail edit/update zone",
                          style: context.theme.textTheme.headline3,
                        ),
                        SizedBox(height: 20,),
                  Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('PujaPurohitFiles/commonCollections/deatil').snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.data==null){
                                return const Center(child: Text('Loading...'),);
                              }
                              return ListView.builder(
                                itemCount: snapshot.data!.size,
                                shrinkWrap: true,
                                itemBuilder: (_,index){
                                  return ListTile(
                                    onTap: (){
                                    //  for(var i=0; i<snapshot.data!.docs[index]['name1'].length;i++ ){
                                    //     controller.detailData.update((val) {
                                    //     val!.name1!.add(snapshot.data!.docs[index]['name1'][i]);
                                    //   });
                                    //  }
                                    },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.docs[index]['image']),                                                    
                                ),
                                title: Text(snapshot.data!.docs[index]['name1'][0]),
                              );
                                });
                            }
                          )),
                  
                         controller.loader.value?const Center(child: CircularProgressIndicator()):Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(onPressed: (){
                                
                              }, child: Text("Add new")),
                              Container(
                    alignment: Alignment.topRight,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(controller.image.value)),
                    ),
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Alert"),
                                    content: const Text(
                                        "Are you sure that you want to update this picture?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            FileUploadInputElement input =
                                                FileUploadInputElement()
                                                  ..accept = 'image/*';
                                            FirebaseStorage fs =
                                                FirebaseStorage.instance;
                                            input.click();
                                            input.onChange.listen((event) {
                                              final file = input.files!.first;
                                              final reader = FileReader();
                                              reader.readAsDataUrl(file);
                                              reader.onLoadEnd
                                                  .listen((event) async {
                                                var snapshot = await fs
                                                    .ref(
                                                        'assets_folder/events_detail_folder')
                                                    .child('$imageId')
                                                    .putBlob(file);
                                                String downloadUrl =
                                                    await snapshot.ref
                                                        .getDownloadURL();
                                            
                                                  controller.image.value = downloadUrl;
                                                  
                                                
                                              });
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Continue")),
                                    ],
                                  ));
                        },
                        child: Text("Edit")),
                  ),
                              addCustomTextField(name, "Name"),
                              addCustomTextField(detailKeyword, "Detail keyword"),
                              addCustomTextField(begin, "begin"),
                              addCustomTextField(end, "End"),
                              addCustomTextField(date, "Date"),
                              addCustomTextField(vikram, "Vikram"),
                              addCustomTextField(pujaName, "Puja Name"),
                              addCustomTextField(pujaKeyword, "Puja Keyword"),
                              addCustomTextField(videoId, "VideoId"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                TextButton(onPressed: (){
                                 controller.paragraph.add(TextEditingController(text: "${controller.textControllerIndex.value}"));
                                  
                                  controller.form.add(
                                   addCustomTextField(controller.paragraph[controller.textControllerIndex.value], "Paragraph ${controller.textControllerIndex.value}")
                                  );
                                 
                                  controller.textControllerIndex.value++;
                                 
                                 
                                }, child: Text("Add Paragraph ${ controller.textControllerIndex.value}"))
                              ],),
                             ListView(                             
                              shrinkWrap: true,
                             children: controller.form,
                            ),

                              InkWell(
                                onTap: ()async{
                                  List<Map<dynamic,List<String>>> paragraphs = [];
                                  List<String> englishParagraph = [];
                                  List<String> name1 =  await translate(name.text);
                                  List<String> begin1 = await translate(begin.text);
                                  List<String> end1 =   await translate(end.text);
                                  List<String> date1 =  await translate(date.text);
                                  List<String> vikram1 = await translate(vikram.text);
                                  for (var i=0; i<controller.paragraph.length;i++) {
                                    List<String> names = await translate(controller.paragraph[i].text);
                                    paragraphs.add({
                                      "$i":names
                                    });
                                    englishParagraph.add(controller.paragraph[i].text);
                                  }                                
                                  Future.delayed(Duration(seconds: 10),()async{
                                     await FirebaseFirestore.instance.doc("PujaPurohitFiles/commonCollections/deatil/#${detailKeyword.text}").set({
                                      'data':FieldValue.arrayUnion(paragraphs),
                                      'name':name.text,
                                      'name1':FieldValue.arrayUnion(name1),
                                      'date':date.text,
                                      'date1':FieldValue.arrayUnion(date1),
                                      'begin':begin.text,
                                      'begin1':FieldValue.arrayUnion(begin1),
                                      'end':end.text,
                                      'end1':FieldValue.arrayUnion(end1),
                                      'pujakeyword':pujaKeyword.text,
                                      'pujaname' : pujaName.text,
                                      'videoId' : videoId.text,
                                      'video' : false,
                                      'deailHindi':[],
                                      'detailEnglish' : FieldValue.arrayUnion(englishParagraph),
                                      'image': controller.image.value,
                                      'detailKeyword':"#${detailKeyword.text}"
                                    
                                  });
                                   
                                  });
                                },

                                child: redButton("Submit"))
                                      ],
                                    )),
                                    
                                
                          
                          ]
                  ),
                ],
              ),
            ),
          );
        },
      
      ),

     
    );
  }

  
}