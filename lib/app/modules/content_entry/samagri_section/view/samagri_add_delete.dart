import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:management/app/modules/content_entry/puja_view/controller/puja_add_controller.dart';
import 'package:management/resources/app_exports.dart';

class SamagriAddDelete extends StatefulWidget {
  @override
  State<SamagriAddDelete> createState() => _SamagriAddDeleteState();
}
  
class _SamagriAddDeleteState extends State<SamagriAddDelete> {

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _name =
        List.generate(11, (i) => TextEditingController());
    List<Widget> _nameTextFields = List.generate(
      11,
      (index) => addSamagriTextField(_name[index], "Samagri Name $index"),
    );  
    SamagriController samagriController = Get.put(SamagriController());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Text(
                    "Samagri edit zone",
                    style: context.theme.textTheme.headline3,
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("assets_folder/puja_items_folder/folder")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return ListView.builder(
                            semanticChildCount: 10,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (_, index) {
                                 List<TextEditingController> _name =
                                        List.generate(5, (i) => TextEditingController(text: snapshot.data!.docs[index]['puja_item_name'][i]));
                                    List<Widget> _nameTextFields = List.generate(
                                      5,
                                      (index) => addSamagriTextField(_name[index], "Samagri Name $index"),                                      
                                    );           

                                     List<TextEditingController> _description =
                                        List.generate(5, (i) =>  TextEditingController(text: snapshot.data!.docs[index]['puja_item_description'][i]));
                                        List<Widget> _descriptionTextFields = List.generate(
                                          5,
                                          (index) =>
                                              addSamagriTextField(_description[index], "Puja Description $index"),
                                    );
                                return ExpansionTile(                                
                                    title: Text(
                                        "${snapshot.data!.docs[index]['puja_item_name'][0]}"),
                                    trailing: const Text("Edit"),
                                    onExpansionChanged: (value) {
                                     snapshot.data!.docs.toList().forEach((element) {
                                        samagriController.samagriName.add(TextEditingController(text: "${snapshot.data!.docs[index]['puja_item_name'][index]}"));
                                       });
                                    },
                                    children: [
                                     Row(
                                       children: [
                                         Expanded(
                                           flex: 1,
                                           child: Column(children: _nameTextFields,)),
                                         Expanded(
                                           flex: 1,
                                           child: Column(children: _descriptionTextFields,))
                                       ],
                                     ),

                                   
                                      
                                    ],
                                  );
                            });
                      }),
                ],
              ),
            )
          ],
        ),
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
   Widget addSamagriTextField(TextEditingController controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: 10,  // allow user to enter 5 line in textfield
          keyboardType: TextInputType.multiline,  
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
            hintStyle:const TextStyle(
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

class SamagriController extends GetxController {
  
  RxList<TextEditingController> samagriName = <TextEditingController>[].obs;
}
