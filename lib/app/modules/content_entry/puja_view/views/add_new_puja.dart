import 'dart:html';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/app_exports.dart';
import '../../../../../resources/responshive.dart';
import '../controller/puja_add_controller.dart';


class AddNewPuja extends StatefulWidget {
  @override
  State<AddNewPuja> createState() => _AddNewPujaState();
}

String pujaId =
    "PJID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";

class _AddNewPujaState extends State<AddNewPuja> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
  String image =
      'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png';
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _name =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _nameTextFields = List.generate(
      11,
      (index) => addPujaTextField(_name[index], "Puja Name $index"),
    );
    List<TextEditingController> _benifits =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _benefits = List.generate(
      11,
      (index) => addPujaTextField(_benifits[index], "Puja Benefits $index"),
    );
    List<TextEditingController> _description =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _descriptionTextFields = List.generate(
      11,
      (index) =>
          addPujaTextField(_description[index], "Puja Description $index"),
    );
    TextEditingController keyword = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController duration = TextEditingController();   


    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.all(0)
          : EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.07),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(image)),
                    ),
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title:const Text("Alert"),
                                    content:const Text(
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
                                                        'assets_folder/puja_ceremony_folder')
                                                    .child('$pujaId')
                                                    .putBlob(file);
                                                String downloadUrl =
                                                    await snapshot.ref
                                                        .getDownloadURL();
                                                setState(() {
                                                  image = downloadUrl;
                                                  //widget.onPressed(downloadUrl);
                                                });
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
                  ExpandablePanel(
                      header: redButton("Add Name"),
                      collapsed: const SizedBox(),
                      expanded: Column(children: _nameTextFields)),
                  ExpandablePanel(
                      header: redButton("Add Description"),
                      collapsed: const SizedBox(),
                      expanded: Column(children: _descriptionTextFields)),
                  ExpandablePanel(
                      header: redButton("Add Benefits"),
                      collapsed: const SizedBox(),
                      expanded: Column(children: _benefits)),
                  ExpandablePanel(
                    header: addPujaTextField(keyword, "Puja Keyword"),
                    collapsed: const SizedBox(),
                    expanded: const SizedBox(),
                  ),
                  ExpandablePanel(
                    header: addPujaTextField(duration, "Puja Duration"),
                    collapsed: const SizedBox(),
                    expanded: SizedBox(),
                  ),
                  ExpandablePanel(
                    header: addPujaTextField(price, "Puja price"),
                    collapsed: const SizedBox(),
                    expanded: SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  chipsSelection(1, "Select God tags"),
                  const SizedBox(
                    height: 20,
                  ),
                  chipsSelection(0, "Benefit"),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     DropdownButtonHideUnderline(
                  //       child: DropdownButton2(
                  //         isExpanded: true,
                  //         hint: Row(
                  //           children: const [
                  //             Expanded(
                  //               child: Text(
                  //                 "Type of Puja",
                  //                 style: const TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         items: controller.typeOfPuja
                  //             .map((item) => DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Text(
                  //                     item,
                  //                     style: const TextStyle(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                     overflow: TextOverflow.ellipsis,
                  //                   ),
                  //                 ))
                  //             .toList(),
                  //         //value: selectedGodList[0],
                  //         onChanged: (value) {
                  //           controller.pujaType.update((val) {
                  //             val = value as String;
                  //           });
                  //         },
                  //         icon: const Icon(
                  //           Icons.arrow_forward_ios_outlined,
                  //         ),
                  //         iconSize: 14,
                  //         buttonPadding: const EdgeInsets.all(20),
                  //         buttonDecoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //           border: Border.all(
                  //             color: Colors.black26,
                  //           ),
                  //         ),
                  //         value: controller.pujaType,
                  //         buttonHeight: 70,
                  //         buttonWidth: 200,
                  //         itemPadding:
                  //             const EdgeInsets.only(left: 14, right: 14),
                  //         dropdownMaxHeight: 200,
                  //         dropdownWidth: 200,
                  //         scrollbarRadius: const Radius.circular(40),
                  //         scrollbarThickness: 6,
                  //         scrollbarAlwaysShow: true,
                  //         offset: const Offset(-20, 0),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                 
                 
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(20),
                          title: "Warning",
                          content: Text("Are you sure you want to remove ?"),                        
                          onConfirm: () {
                           List<Map<String , dynamic>> itemsNeeded = [{}];
                             Map<String , dynamic>a = {};
                              controller.foundPlayers.value.asMap().forEach((qkey, qvalue) {
                                //  if([qvalue][qkey]['quantity']!='quantity'){
                                //    itemsNeeded.add({
                                //      'id':[qvalue][qkey]['id'], 'quantity':[qvalue][qkey]['quantity']
                                //    });
                                //  }   
                               
                                                  
                              });
                            // List<String> names = [];
                            // List<String> description = [];

                            // _name.forEach((element) {
                            //   names.add(element.text);
                            // });
                            // _description.forEach((element) {
                            //   description.add(element.text);
                            // });
                            // Future.delayed(Duration(seconds: 4), () async{
                            //  await FirebaseFirestore.instance
                            //       .doc(
                            //           '/assets_folder/puja_ceremony_folder/folder/$pujaId')
                            //       .set({
                            //     'puja_ceremony_name':
                            //         FieldValue.arrayUnion(names),
                            //     'puja_ceremony_description':
                            //         FieldValue.arrayUnion(description),
                            //     'puja_ceremony_display_picture': image,
                            //     'puja_ceremony_god_filter':
                            //         FieldValue.arrayUnion(
                            //             controller.selectedGodList),
                            //     'puja_ceremony_benefits_filter':
                            //         FieldValue.arrayUnion(
                            //             controller.selectedBenefitList),
                            //     'puja_ceremony_standard_price': price.text,
                            //     'puja_ceremony_standard_duration':
                            //         duration.text,
                            //     'puja_ceremony_type_filter':
                            //         controller.pujaType.value,
                            //     'puja_ceremony_id': pujaId,
                            //     'puja_ceremony_promise': [],
                            //     'puja_ceremony_performing_pandits': [],
                            //     'puja_ceremony_steps': [],
                            //     'puja_ceremony_key_insights': null,
                            //     'puja_ceremony_date_of_creation':
                            //         FieldValue.serverTimestamp()
                            //   });
                            // }).whenComplete(() {
                            //   List<Map<String , dynamic>> itemsNeeded = [{}];
                            //  Map<String , dynamic>a = {};
                            //   controller.foundPlayers.value.asMap().forEach((qkey, qvalue) {
                            //     //  if([qvalue][qkey]['quantity']!='quantity'){
                            //     //    itemsNeeded.add({
                            //     //      'id':[qvalue][qkey]['id'], 'quantity':[qvalue][qkey]['quantity']
                            //     //    });
                            //     //  }   
                               
                                                  
                            //   });
                            // //    controller.states.asMap().forEach((key, value) async{                                                                 
                            // //        Future.delayed(Duration(seconds: 5),()async{
                            // //         await FirebaseFirestore.instance
                            // //           .doc('/assets_folder/puja_ceremony_folder/folder/PJID2022310165417/puja_item_folder/${value['name']}')
                            // //           .set({
                            // //             'items': FieldValue.arrayUnion(itemsNeeded)                                       
                            // //           });
                            // //           Get.back();
                            // //        });                                                          
                            // // });
                            // });
                           
                           
                          },
                          onCancel: () {
                            Get.back();
                          });
                    },
                    child: redButton("Submit"),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.filterPlayer(value),
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                        itemCount: controller.foundPlayers.value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Checkbox(
                                value: controller.foundPlayers.value[index]
                                    ['selected'],
                                onChanged: (value) {
                                  controller.foundPlayers.update((val) {
                                    val![index]['selected'] = value;
                                  });
                                }),
                            trailing: SizedBox(
                              width: 100,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: controller
                                        .foundPlayers.value[index]['quantity']),
                                onChanged: (value) {
                                  controller.foundPlayers.update((val) {
                                    val![index]['quantity'] = value;
                                  });
                                },
                              ),
                            ),
                            title: Text(
                              "${controller.foundPlayers.value[index]['name']}",                              
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }

  Widget chipsSelection(int index, String text) {
    return Obx(() => Container(    
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                        children: index == 1
                            ? controller.selectedGodListWidget
                            : controller.selectedBeneditListWidget),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Expanded(
                              child: Text(
                                text,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: index == 1
                            ? controller.gods
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList()
                            : controller.benefit
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                        //value: selectedGodList[0],
                        onChanged: (value) {
                          if (index == 1) {
                            if (controller.selectedGodList.contains(value)) {
                                Get.snackbar("Duplicay", "We restricted duplicay",
                                    backgroundColor:
                                        context.theme.backgroundColor);
                              } else {
                                
              
                                controller.selectedGodList.add(value as String);
                                controller.selectedGodListWidget.add(Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Chip(label: Text(value.toString())),
                                ));
                              }
                          } else {
                             if (controller.selectedBenefitList.contains(value)) {
                                Get.snackbar("Duplicay", "We restricted duplicay",
                                    backgroundColor:
                                        context.theme.backgroundColor);
                              } else {
                                controller.selectedBenefitList.add(value as String);
                                controller.selectedBeneditListWidget.add(Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Chip(label: Text(value.toString())),
                                ));
                              }
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        buttonPadding: const EdgeInsets.all(20),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                        ),
                        buttonHeight: 70,
                        buttonWidth: 200,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 200,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () {
                    if (index == 1) {
                        controller.selectedGodList.clear();
                        controller.selectedGodListWidget.clear();
                      } else {
                        controller.selectedBeneditListWidget.clear();
                        controller.selectedBenefitList.clear();
                      }
                  },
                  child: Text(
                    "Clear Selection",
                    style: TextStyle(color: context.theme.backgroundColor),
                  ))
            ],
          ),
        ));
  }

  Container redButton(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red, width: 2.0)),
      child: Text(text),
    );
  }

  Widget addPujaTextField(TextEditingController controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,

            hintText: hintText,

            //make hint text
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: hintText,
            //lable style
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

class SamagriModel {
  List<dynamic>? name = [];
  String? quanatity = '';
  bool? isChecked = false;
  SamagriModel({this.name, this.quanatity, this.isChecked});
}

class CheckBoxListTileModel {
  int? userId;
  String? title;
  bool? isCheck;

  CheckBoxListTileModel({this.userId, this.title, this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(userId: 1, title: "Android", isCheck: true),
      CheckBoxListTileModel(userId: 2, title: "Flutter", isCheck: false),
      CheckBoxListTileModel(userId: 3, title: "IOS", isCheck: false),
      CheckBoxListTileModel(userId: 4, title: "PHP", isCheck: false),
      CheckBoxListTileModel(userId: 5, title: "Node", isCheck: false),
    ];
  }
}

