import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

import '../../../../../resources/app_exports.dart';
import '../../../../../resources/responshive.dart';
import '../controller/puja_add_controller.dart';

class UpdatePuja extends StatefulWidget {
  final String pujaId;
  final TextEditingController keyword ;
  final TextEditingController price;
  final TextEditingController duration;
  final List<dynamic> updateName;
  final List<dynamic> updateDescription;
  final List<dynamic> updateBenefit;
  const UpdatePuja({Key? key,required this.pujaId, required this.updateName,required this.updateDescription, required this.updateBenefit,
  required this.keyword, required this.price , required this.duration}) : super(key: key);
  @override
  State<UpdatePuja> createState() => _UpdatePujaState();
}


class _UpdatePujaState extends State<UpdatePuja> {
  String image =
      'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png';
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _name =
        List.generate(5, (i) => TextEditingController(text:widget.updateName[i]));
    List<Widget> _nameTextFields = List.generate(
      5,
      (index) => addPujaTextField(_name[index], "Puja Name $index"),
    );
    List<TextEditingController> _benifits =
        List.generate(5, (i) => TextEditingController(text: widget.updateBenefit[i]));
    List<Widget> _benefits = List.generate(
      5,
      (index) => addPujaTextField(_benifits[index], "Puja Benefits $index"),
    );

    List<TextEditingController> _description =
        List.generate(5, (i) => TextEditingController(text:widget.updateDescription[i]));
    List<Widget> _descriptionTextFields = List.generate(
      5,
      (index) =>
          addPujaTextField(_description[index], "Puja Description $index"),
    );
    TextEditingController keyword = widget.keyword;
    TextEditingController price = widget.price;
    TextEditingController duration = widget.duration;

    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? const EdgeInsets.all(0)
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
                                    title: const Text("Alert"),
                                    content: const Text(
                                        "Are you sure that you want to update this picture?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel")),
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
                                                    .child('${widget.pujaId}')
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
                                          child: const Text("Continue")),
                                    ],
                                  ));
                        },
                        child: const Text("Edit")),
                  ),
                  ExpandablePanel(
                      header: redButton("Update Name"),
                      collapsed: const SizedBox(),
                      expanded: Column(children: _nameTextFields)),
                  ExpandablePanel(
                      header: redButton("Update Description"),
                      collapsed: const SizedBox(),
                      expanded: Column(children: _descriptionTextFields)),
                  ExpandablePanel(
                      header: redButton("Update Benefits"),
                      collapsed: const SizedBox(),
                      expanded: Column(children: _benefits)),
                  ExpandablePanel(
                    header: addPujaTextField(keyword, "Update Puja Keyword"),
                    collapsed: const SizedBox(),
                    expanded: const SizedBox(),
                  ),
                  ExpandablePanel(
                    header: addPujaTextField(duration, "Update Puja Duration"),
                    collapsed: const SizedBox(),
                    expanded: SizedBox(),
                  ),
                  ExpandablePanel(
                    header: addPujaTextField(price, "Update Puja price"),
                    collapsed: const SizedBox(),
                    expanded: SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GodCheckBox(text:"Update select God tags"),
                  const SizedBox(
                    height: 20,
                  ),
                  BenefitCheckBox(text:"Update benefit"),
                  const SizedBox(
                    height: 20,
                  ),                 
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(20),
                          title: "Warning",
                          content: Text("Are you sure you want to remove ?"),
                          onConfirm: () {                           
                            List<String> names = [];
                            List<String> description = [];
                            List<String> benefits = [];
                             List<String> promises = [];
                            List<String> gods = [];
                            String type;
                            for (var element in controller.benefit.value) {
                             if(element['value']==true){
                               promises.add(element['type']);
                             }
                            }
                             for (var element in controller.god.value) {
                             if(element['value']==true){
                               gods.add(element['type']);
                             }
                            }
                            _name.forEach((element) {
                              names.add(element.text);
                            });
                            _description.forEach((element) {
                              description.add(element.text);
                            });
                              _benifits.forEach((element) {
                              benefits.add(element.text);
                            });
                            Future.delayed(Duration(seconds: 4), () async{
                             await FirebaseFirestore.instance
                                  .doc(
                                      '/assets_folder/puja_ceremony_folder/folder/${widget.pujaId}')
                                  .update({
                                 'puja_ceremony_keyword': keyword.text,     
                                'puja_ceremony_name':
                                    FieldValue.arrayUnion(names),
                                'puja_ceremony_description':
                                    FieldValue.arrayUnion(description),
                                'puja_ceremony_display_picture': image,
                                'puja_ceremony_god_filter':
                                    FieldValue.arrayUnion(
                                        gods),
                                'puja_ceremony_benefits_filter':FieldValue.arrayUnion(
                                        benefits),                                    
                                'puja_ceremony_standard_price': price.text,
                                'puja_ceremony_standard_duration':
                                    duration.text,
                                'puja_ceremony_type_filter':  controller.typeOfPuja!.value,
                                'puja_ceremony_id': widget.pujaId,
                                'puja_ceremony_promise': FieldValue.arrayUnion(
                                        promises),
                                'puja_ceremony_performing_pandits': [],
                                'puja_ceremony_steps': [],
                                'puja_ceremony_key_insights': null,
                                'puja_ceremony_date_of_creation':
                                    FieldValue.serverTimestamp()
                              });
                            }).whenComplete(() {
                              List<Map<String , dynamic>> itemsNeeded=[];
                              int len = controller.foundPlayers.value.length;
                              for (int i = 0; i < len; i++) {
                                if (controller.foundPlayers.value[i]
                                ["quantity"] !=
                                    "quantity") {                                 
                                  itemsNeeded.add({
                                    'id': '${controller.foundPlayers.value[i]["id"]}',
                                    'quantity' :'${controller.foundPlayers.value[i]["quantity"]}',                                   
                                  });
                                }
                              }                             
                               controller.states.asMap().forEach((key, value) async{
                                   Future.delayed(Duration(seconds: 1),()async{
                                    await FirebaseFirestore.instance
                                      .doc('/assets_folder/puja_ceremony_folder/folder/${widget.pujaId}/puja_item_folder/${value['name']}')
                                      .set({
                                        'items' :FieldValue.arrayUnion(itemsNeeded)
                                      });
                                      Get.back();
                                   });
                                   FirebaseFirestore.instance
                                      .doc('/assets_folder/puja_ceremony_folder').update({
                                            'total_puja_ceremony' : FieldValue.increment(1)
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
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        minLines: 1,
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
            hintStyle: const  TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: hintText,
            //lable style
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

