import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/resources/responshive.dart';

import '../../../../resources/app_components/custom_searchable_dropdown.dart';
import '../../../../resources/app_strings.dart';
import '../models/pandit_users_model.dart';

class PanditUserList extends StatefulWidget{
  @override
  State<PanditUserList> createState() => _PanditUserListState();
}

class _PanditUserListState extends State<PanditUserList> {
  int limit = 20;
  bool location = false;
  @override
  Widget build(BuildContext context) {
   return Scaffold(     
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users_folder/folder/pandit_users').orderBy("pandit_joining_date",descending: true).limit(limit).get(),          
          builder: (context, snapshot) {
            if(snapshot.data!=null){  
                 List<DropdownMenuItem> list = List<DropdownMenuItem>.generate(
              snapshot.data!.size,
              (index) => DropdownMenuItem(
                  value: Purohit(snapshot.data!.docs[index]).name +
                      Purohit(snapshot.data!.docs[index]).uid +
                      Purohit(snapshot.data!.docs[index]).mobile,
                  child: PurohitTile(
                    documentSnapshot: snapshot.data!.docs[index],
                  )));                                       
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      SearchChoices.single(
                            items: list,
                            value: "",
                            onChanged: () {},
                            underline: SizedBox(),
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            displayClearIcon: false,
                          ),
                     SizedBox(width: 10,),
                    TextButton(
                      
                      onPressed: (){
                       
                      setState(() {
                        limit = limit+10;
                      });
                    }, child: Text("Icrement by 10",style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black54))),                                       
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: snapshot.data!.docs.isNotEmpty
                      ? GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                              crossAxisCount: ResponsiveWidget.isSmallScreen(context)?2 :ResponsiveWidget.isMobileLarge(context)? 3: ResponsiveWidget.isMediumScreen(context)? 4:6,  
                              crossAxisSpacing: 4.0,  
                              mainAxisSpacing: 4.0  
                          ),                                         
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => InkWell(
                            hoverColor: Colors.transparent,
                            onTap: (){                            
                              Get.toNamed('/home/${AppStrings.MANAGEMENT}/pandit_users/${snapshot.data!.docs[index]["pandit_id"]}');
                            },
                            child: Card(
                              key: ValueKey(snapshot.data!.docs[index]["pandit_uid"]),                       
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(5),
                                leading: CircleAvatar(
                                  maxRadius: 25,
                                  backgroundImage: NetworkImage(snapshot.data!.docs[index]["pandit_display_profile"]),
                                ),
                                isThreeLine: true,
                                title: Text(snapshot.data!.docs[index]['pandit_name'],style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,fontSize: 18),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Age: ${snapshot.data!.docs[index]["pandit_age"].toString()} years old'),
                                        SizedBox(height: 5,),
                                         Text(
                                        'Number: ${snapshot.data!.docs[index]["pandit_mobile_number"].toString()}'),
                                        SizedBox(height: 5,),
                                         Text(
                                        'Verification: ${snapshot.data!.docs[index]["pandit_verification_status"].toString()}'),
                                        SizedBox(height: 5,),
                                         Text(
                                        'State: ${snapshot.data!.docs[index]["pandit_state"].toString()}'),
                          
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                ),
              ],
            );
          
          }
            return const Center(child: Text("Loading..."));
          }
          
        ),
      ),
    );
  }
}

class PurohitTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const PurohitTile({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => PurohitProfileLandingPage(
        //           documentSnapshot: documentSnapshot,
        //         )));
      },
      contentPadding: EdgeInsets.all(10),
      leading: CircleAvatar(backgroundImage: NetworkImage('${Purohit(documentSnapshot).profileUrl}'),),
      title: Row(
        children: [
          Text("${Purohit(documentSnapshot).name} "),
          Purohit(documentSnapshot).verification
              ? Icon(
                  Icons.verified,
                  color: Colors.blue,
                )
              : SizedBox()
        ],
      ),
      );
  }
}
