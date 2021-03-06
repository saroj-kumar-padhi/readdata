import 'dart:html';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/app/purohit_profile_mgmt/reusable_widgets.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

import '../../../../../resources/app_exports.dart';
import '../../../../../resources/app_functions.dart';
import '../../../../../resources/responshive.dart';
import '../controller/puja_add_controller.dart';

class AddNewPuja extends StatefulWidget {
  final AsyncSnapshot<DocumentSnapshot>? fields;
  final bool? edit;

  const AddNewPuja({Key? key, this.fields, this.edit}) : super(key: key);

  @override
  State<AddNewPuja> createState() => _AddNewPujaState();
}

String pujaId =
    "PJID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";

class _AddNewPujaState extends State<AddNewPuja> {
  String image =
      'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png';
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _name =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _nameTextFields = List.generate(
      11,
      (index) => addCustomTextField(_name[index], "Puja Name $index"),
    );
    List<TextEditingController> _benifits =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _benefits = List.generate(
      11,
      (index) => addCustomTextField(_benifits[index], "Puja Benefits $index"),
    );

    List<TextEditingController> _description =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _descriptionTextFields = List.generate(
      11,
      (index) =>
          addCustomTextField(_description[index], "Puja Description $index"),
    );
    TextEditingController keyword = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController duration = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController benefit = TextEditingController();
    TextEditingController description = TextEditingController();

    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.all(0)
          : EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
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
                  addCustomTextField(name, "Name"),
                  Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        maxLines: 10,
        minLines: 1,
        keyboardType: TextInputType.multiline,
          controller: description,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,

            hintText: "Description",

            //make hint text
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: "Description",
            //lable style
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    ),
                  addCustomTextField(benefit, "Benefits"),
                  addCustomTextField(keyword, "Puja Keyword"),
                  addCustomTextField(duration, "Puja Duration"),
                  addCustomTextField(price, "Puja price"),                
                  const SizedBox(
                    height: 20,
                  ),
                  GodCheckBox(text: "Select tags"),
                  const SizedBox(
                    height: 20,
                  ),
                  BenefitCheckBox(text: "Benefit tags"),
                  const SizedBox(
                    height: 20,
                  ),
                   DropdownButton<String>(
                        items: <String>[
                          'Puja for Health',
                          'Puja for Wealth',
                          'Ceremony Puja',
                          'Katha & Path',
                          'Festival Puja',
                          'Puja for Study'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Obx(() => Text(controller.typeOfPuja.value)),
                        onChanged: (value) {
                         controller.change(value);
                         print(controller.typeOfPuja);
                        },
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(20),
                          title: "Warning",
                          content: Text("Are you sure you want to add ?"),
                          onConfirm: ()async {
                            List<String> names = await translate(name.text);
                            List<String> descriptions = await translate(description.text);
                            List<String> benefits = await translate(benefit.text);
                            List<String> promises = [];
                            List<String> gods = [];
                            for (var element in controller.benefit.value) {
                              if (element['value'] == true) {
                                promises.add(element['type']);
                              }
                            }
                            for (var element in controller.god.value) {
                              if (element['value'] == true) {
                                gods.add(element['type']);
                              }
                            }                           
                            Future.delayed(Duration(seconds: 4), () async {
                              await FirebaseFirestore.instance
                                  .doc(
                                      '/assets_folder/puja_ceremony_folder/folder/$pujaId')
                                  .set({
                                'puja_ceremony_keyword': keyword.text,
                                'puja_ceremony_name':
                                    FieldValue.arrayUnion(names),
                                'puja_ceremony_description':
                                    FieldValue.arrayUnion(descriptions),
                                'puja_ceremony_display_picture': image,
                                'puja_ceremony_god_filter':
                                    FieldValue.arrayUnion(gods),
                                'puja_ceremony_benefits_filter':
                                    FieldValue.arrayUnion(benefits),
                                'puja_ceremony_standard_price': price.text,
                                'puja_ceremony_standard_duration':
                                    duration.text,
                                'puja_ceremony_type_filter':
                                    controller.typeOfPuja.value,
                                'puja_ceremony_id': pujaId,
                                'puja_ceremony_promise':
                                    FieldValue.arrayUnion(promises),
                                'puja_ceremony_performing_pandits': [],
                                'puja_ceremony_steps': [],
                                'puja_ceremony_key_insights': null,
                                'puja_ceremony_date_of_creation':
                                    FieldValue.serverTimestamp()
                              });
                            }).whenComplete(() {
                              List<Map<String, dynamic>> itemsNeeded = [];
                              int len = controller.foundPlayers.value.length;
                              for (int i = 0; i < len; i++) {
                                if (controller.foundPlayers.value[i]
                                        ["quantity"] !=
                                    "quantity") {
                                  itemsNeeded.add({
                                    'id':
                                        '${controller.foundPlayers.value[i]["id"]}',
                                    'quantity':
                                        '${controller.foundPlayers.value[i]["quantity"]}',
                                    'type':
                                        '${controller.foundPlayers.value[i]["type"]}',
                                  });
                                }
                              }
                              controller.states
                                  .asMap()
                                  .forEach((key, value) async {
                                Future.delayed(const Duration(seconds: 1),
                                    () async {
                                  await FirebaseFirestore.instance
                                      .doc(
                                          '/assets_folder/puja_ceremony_folder/folder/$pujaId/puja_item_folder/${value['name']}')
                                      .set({
                                    'items': FieldValue.arrayUnion(itemsNeeded)
                                  });
                                  Get.back();
                                });
                                FirebaseFirestore.instance
                                    .doc('/assets_folder/puja_ceremony_folder')
                                    .update({
                                  'total_puja_ceremony': FieldValue.increment(1)
                                });
                              });
                            });
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
                TextButton(onPressed: (){
                   String sId =
                      "SID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";
                      TextEditingController newname = TextEditingController();
                      TextEditingController newdescription =
                          TextEditingController();
                      TextEditingController newSamagriPrice =
                          TextEditingController();
                      TextEditingController newSamagriMargin = TextEditingController();
                   Get.bottomSheet(
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
                            height: Get.height*0.9,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(                            
                              children: [
                                addCustomTextField(newname, "Name"),
                                addCustomTextField(newdescription, "Description"),
                                addCustomTextField(newSamagriPrice, "Standard Price"),
                                addCustomTextField(newSamagriMargin, "Samagri margin"),
                                  

                                    InkWell(
                                      onTap: ()async{
                                       final List<String> names = await translate(newname.text);
                                       final List<String> description = await translate(newdescription.text);
                                                                           

                                         await FirebaseFirestore.instance.doc('assets_folder/puja_items_folder/folder/$sId').set({
                                            'puja_item_description':FieldValue.arrayUnion(description),
                                            'puja_item_name' :FieldValue.arrayUnion(names),
                                            'puja_item_price' : newSamagriPrice.text,
                                            'puja_item_margin': newSamagriMargin.text,
                                            'puja_item_vendors':[],
                                            'puja_item_display_picture':'https://i.etsystatic.com/18640148/r/il/89d229/2073623160/il_794xN.2073623160_nq7m.jpg'

                                          });

                                        controller.foundPlayers.update((val) {
                                          val!.add({
                                             "id": sId,
                                            "name": names[1],
                                            "selected": false,
                                            "quantity": 'quantity',
                                            "type" : "deliver"
                                          });
                                        });
                                          Get.back();
                                          Get.showSnackbar(const GetSnackBar(message: 'Updated samgri',duration: Duration(seconds: 2),));
                                      },
                                      child: redButton('Submit'))
                                      
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: context.theme.backgroundColor,
                        isScrollControlled: true
                        );
                }, child: Text("Add New Samagri")),
                SizedBox(height: 10,),
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
                              width: 300,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: controller.foundPlayers
                                              .value[index]['quantity']),
                                      onChanged: (value) {
                                        controller.foundPlayers.update((val) {
                                          val![index]['quantity'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Obx(() => DropdownButton<String>(
                                          items: <String>[
                                            'deliver',
                                            'non_deliver',
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: Text(
                                              '${controller.foundPlayers.value[index]['type']}'),
                                          onChanged: (value) {
                                            controller.foundPlayers
                                                .update((val) {
                                              val![index]['type'] = value;
                                            });
                                          },
                                        )),
                                  ),
                                ],
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

  

 
}
