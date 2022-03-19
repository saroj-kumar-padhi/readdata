import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

import '../../../../../resources/app_exports.dart';
import '../controller/add_update_detail_controller.dart';

class AddUpdateDetailView extends StatelessWidget{
  AddUpdateDetailController addUpdateDetailController = Get.put(AddUpdateDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<AddUpdateDetailController>(
        init: AddUpdateDetailController(), 
        initState: AddUpdateDetailController().addBlankText(),       
        builder: (controller) {
        List<TextEditingController> name1 =
        List.generate(10, (i) => TextEditingController(text: controller.detailData.value.name1![i]));
         List<Widget> _name1TextFields = List.generate(
            10,
            (index) => addCustomTextField(
                name1[index], "Name $index"),
          );
           List<TextEditingController> date1 =
        List.generate(10, (i) => TextEditingController(text: controller.detailData.value.date1![i]));
         List<Widget> _date1TextFields = List.generate(
            10,
            (index) => addCustomTextField(
                name1[index], "Date $index"),
          );
           List<TextEditingController> end1 =
        List.generate(10, (i) => TextEditingController(text: controller.detailData.value.end1![i]));
         List<Widget> _endTextFields = List.generate(
            10,
            (index) => addCustomTextField(
                name1[index], "End $index"),
          );
           List<TextEditingController> begin1 =
        List.generate(10, (i) => TextEditingController(text: controller.detailData.value.begin1![i]));
         List<Widget> _beginTextFields = List.generate(
            10,
            (index) => addCustomTextField(
                name1[index], "Begin $index"),
          );
           List.generate(10, (i) => TextEditingController(text: controller.detailData.value.vikram1![i]));
         List<Widget> _vikram1TextFields = List.generate(
            10,
            (index) => addCustomTextField(
                name1[index], "Vikram $index"),
          );
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
                  
                          Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(onPressed: (){
                                
                              }, child: Text("Add new")),
                               ExpandablePanel(
                                header: redButton("Add Name"),
                                collapsed: const SizedBox(),
                                expanded: Column(children: _name1TextFields)),

                                 ExpandablePanel(
                                header: redButton("Add Date"),
                                collapsed: const SizedBox(),
                                expanded: Column(children: _date1TextFields)),
                                 ExpandablePanel(
                                header: redButton("Add begin"),
                                collapsed: const SizedBox(),
                                expanded: Column(children: _beginTextFields)),
                                 ExpandablePanel(
                                header: redButton("Add End"),
                                collapsed: const SizedBox(),
                                expanded: Column(children: _endTextFields)),
                                 ExpandablePanel(
                                header: redButton("Add Name"),
                                collapsed: const SizedBox(),
                                expanded: Column(children: _name1TextFields)),
                                ExpandablePanel(
                                header: redButton("Add Vikram"),
                                collapsed: const SizedBox(),
                                expanded: Column(children: _vikram1TextFields)),
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