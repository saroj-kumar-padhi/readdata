import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/resources/app_components/function_cards.dart';
import 'package:management/resources/app_components/menu_bar_tiles.dart';
import 'package:management/resources/app_exports.dart';
import 'package:management/resources/responshive.dart';

import '../../../../resources/app_strings.dart';

class AddUpdatePuja extends StatelessWidget{
  String tab = Get.parameters['tab']!;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       children: [
         Row(
           children: [
             Expanded(
               flex: 1,
               child: Padding(
                 padding: EdgeInsets.only(top: Get.height*0.2),
                 child: Column(
                   children: [
                    MenuBarTile(selectedTab: 'up', iconData: LineIcons.fileUpload, titleText: 'Update Puja',tab:tab,onTap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/up');},),
                    MenuBarTile(selectedTab: 'an', iconData: LineIcons.newspaper, titleText: 'Add Puja',tab:tab ,onTap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/an');},),
                    MenuBarTile(selectedTab: 'rp', iconData: LineIcons.recycle, titleText: 'Remove Puja',tab:tab ,onTap: (){Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/rp');},),
                   ],
                 ),
               )),
             Expanded(
               flex: 4,
               child: Container(
                 margin: EdgeInsets.only(top: Get.height*.1),
                 child: StreamBuilder<QuerySnapshot>(
                   stream: FirebaseFirestore.instance.collection('/assets_folder/puja_ceremony_folder/folder').snapshots(),
                   builder: (context, snapshot) {
                     if(snapshot.data==null){
                       return const Center(child: CircularProgressIndicator(),);
                     }
                     List<Widget> _pujaCards = [];
                     snapshot.data!.docs.forEach((element) {
                       _pujaCards.add(PujaCards(text: element['puja_ceremony_name'][0], iconData: element['puja_ceremony_display_picture'],ontap: (){},));
                      });
                      if(tab=='up'){
                        return Wrap(
                       direction: Axis.horizontal,
                       children: _pujaCards,
                     );
                      }
                      else if(tab=='an'){
                        return AddNewPuja();    
                      }
                      return SizedBox();
                     
                   }
                 )
               ),
             ),
           ],
         )
       ],
     ),
   );
  }

}


class AddNewPuja extends StatefulWidget{
  @override
  State<AddNewPuja> createState() => _AddNewPujaState();
}
 List<String> selectedGodList = [];
    List<Widget> selectedGodListWidget = [];
     List<String> selectedBenefitList = [];
    List<Widget> selectedBeneditListWidget = [];
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
  String pujaType = 'Puja for health';
  
class _AddNewPujaState extends State<AddNewPuja> {
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
  String image = 'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png';
  HomeController controller = Get.put(HomeController());
 
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _name = List.generate(11, (i) => TextEditingController());   
    List<Widget> _nameTextFields = List.generate(11, (index) => addPujaTextField(_name[index],"Puja Name $index"),);
    List<TextEditingController> _benifits = List.generate(11, (i) => TextEditingController());   
    List<Widget> _benefits = List.generate(11, (index) => addPujaTextField(_name[index],"Puja Benefits $index"),);
    List<TextEditingController> _description = List.generate(11, (i) => TextEditingController());   
    List<Widget> _descriptionTextFields = List.generate(11, (index) => addPujaTextField(_name[index],"Puja Description $index"),);
    TextEditingController keyword = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController duration = TextEditingController();
    List<SamagriModel> allSamagris = [];    
    bool checkbox;
    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context)?EdgeInsets.all(0) :EdgeInsets.only(left:Get.width*0.15,right: Get.width*0.07),
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
                    height: 100,width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(image)),
                      
                    ),child: TextButton(onPressed: (){
                          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Alert"),
                    content:
                        Text("Are you sure that you want to update this picture?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            FileUploadInputElement input = FileUploadInputElement()
                              ..accept = 'image/*';
                            FirebaseStorage fs = FirebaseStorage.instance;
                            input.click();
                            input.onChange.listen((event) {
                              final file = input.files!.first;
                              final reader = FileReader();
                              reader.readAsDataUrl(file);
                              reader.onLoadEnd.listen((event) async {
                                var snapshot =
                                    await fs.ref().child('pujas').putBlob(file);
                                String downloadUrl =
                                    await snapshot.ref.getDownloadURL();
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
                    }, child: Text("Edit")),),
                  ExpandablePanel(
                    header:  redButton("Add Name"),
                    collapsed: const SizedBox(),
                    expanded: Column(
                      children: _nameTextFields
                    )),
                     ExpandablePanel(
                    header: redButton("Add Description"),
                    collapsed: const SizedBox(),
                    expanded: Column(
                      children: _descriptionTextFields
                    )),
                     ExpandablePanel(
                    header:  redButton("Add Benefits"),
                    collapsed: const SizedBox(),
                    expanded: Column(
                      children: _benefits
                    )),
                    ExpandablePanel(
                    header:  addPujaTextField(keyword,"Puja Keyword"),
                    collapsed: const SizedBox(),
                    expanded: const SizedBox(),
                    ),
                    ExpandablePanel(
                    header:  addPujaTextField(duration,"Puja Duration"),
                    collapsed: const SizedBox(),
                    expanded:SizedBox(),
                    ),
                    ExpandablePanel(
                    header:  addPujaTextField(price,"Puja price"),
                    collapsed: const SizedBox(),
                    expanded:SizedBox(),
                    ),
                    const SizedBox(height: 20,), 
                    chipsSelection(1,"Select God tags")             ,             
                     const SizedBox(height: 20,), 
                    chipsSelection(0,"Benefit")             ,             
                  SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [                           
                                        Expanded(
                                          child: Text(
                                           "Type of Puja",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: typeOfPuja
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
                                        setState(() {
                                          pujaType = value.toString();
                                        });
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
                                  value: pujaType,
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
              
              
                   InkWell(
                    onTap: (){
                      Get.defaultDialog(
                        contentPadding: EdgeInsets.all(20),
                        title: "Warning",
                        content: Text("Are you sure you want to remove ?"),
                        // confirm: Text("Confirm"),
                        // cancel:  Text("Cancel"),
                        onConfirm: (){
                          List<String> names = [];
                          _name.forEach((element) {names.add(element.text) ;});
                        Future.delayed(Duration(seconds: 2),(){
                           FirebaseFirestore.instance.doc('/assets_folder/puja_ceremony_folder/folder/id').set({
                              'puja_name': FieldValue.arrayUnion(names)
                         });
                        });
                        },
                        onCancel: (){Get.back();}
                      );
                    },
                    child: redButton("Submit"),
                  )
                ],
              ),
            ),
          ),
       
           Expanded(
             flex: 1,
             child:  Column(
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
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      controller.foundPlayers.value[index]['name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                      Text(controller.foundPlayers.value[index]['country']),
                  ),
                ),
              ),)
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
  Container chipsSelection(int index,String text) {
    return Container(
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.start,
                children: [
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: index == 1 ? selectedGodListWidget: selectedBeneditListWidget
                      ),
                     SizedBox(height: 20,),   
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children:  [                           
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
                          items: index==1?gods
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
                              .toList():benefit
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
                            if(index==1){
                               setState(() {
                              if(selectedGodList.contains(value)){
                                Get.snackbar("Duplicay", "We restricted duplicay",backgroundColor: context.theme.backgroundColor);
                              }
                              else{
                             selectedGodList.add(value as String);
                             selectedGodListWidget.add(Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Chip(label: Text(value.toString())),
                              ));
                              }                             
                            });
                            }
                           else{
                              setState(() {
                              if(selectedBenefitList.contains(value)){
                                Get.snackbar("Duplicay", "We restricted duplicay",backgroundColor: context.theme.backgroundColor);
                              }
                              else{
                              selectedBenefitList.add(value as String);
                              selectedBeneditListWidget.add(Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Chip(label: Text(value.toString())),
                              ));
                              }                             
                            });
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
                  const SizedBox(width: 20,),
                  TextButton(onPressed: (){ setState(() {
                    if(index==1){
                      selectedGodList.clear(); selectedGodListWidget.clear();
                    }
                    else{
                      selectedBeneditListWidget.clear(); selectedBenefitList.clear();
                    }
                  }); }, child: Text("Clear Selection",style: TextStyle(color: context.theme.backgroundColor),))
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
                border: Border.all(color: Colors.red,width: 2.0)
              ),
              child: Text(text),
            );
  }

  Widget addPujaTextField(TextEditingController controller,hintText) {  
  return 
      Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: controller,
            decoration:InputDecoration(
              border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.blue, width: 1.0),
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
                labelText:hintText,
                //lable style
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),
             
            )
          ),
    );
    
      
    
  }
}
class SamagriModel{
  List<dynamic>? name =[];
  String? quanatity='';
  bool? isChecked = false;
  SamagriModel({this.name,this.quanatity,this.isChecked});
}
class CheckBoxListTileModel {
  int? userId;  
  String? title;
  bool? isCheck;

  CheckBoxListTileModel({this.userId,this.title, this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          userId: 1,         
          title: "Android",
          isCheck: true),
      CheckBoxListTileModel(
          userId: 2,         
          title: "Flutter",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 3,          
          title: "IOS",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 4,          
          title: "PHP",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 5,          
          title: "Node",
          isCheck: false),
    ];
  }
}

class HomeController extends GetxController {
  final List<Map<String, dynamic>>allSamagris = [   
  ];
  Rx<List<Map<String, dynamic>>> foundPlayers =
      Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() {
    super.onInit();
    samagriFetch();
    
  }

  @override
  void onReady() {
    super.onReady();
  }
  Future<void> samagriFetch()async{
   await FirebaseFirestore.instance.collection("assets_folder/puja_items_folder/folder").get().then((value){
      value.docs.forEach((element) { 
        print(element['puja_item_name'][0]);
          allSamagris.add({
            "name": "gg", 
          });
      });
    } ).whenComplete(() {
      foundPlayers.value = allSamagris;
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