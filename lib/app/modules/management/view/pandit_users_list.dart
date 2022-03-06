import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/resources/responshive.dart';

import '../../../../resources/app_strings.dart';

class PanditUserList extends StatefulWidget{
  @override
  State<PanditUserList> createState() => _PanditUserListState();
}

class _PanditUserListState extends State<PanditUserList> {
  int limit = 20;
  bool location = false;
  final List<Map<String, dynamic>> _allUsers = [
   
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilterName(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()) && user['age']>30)
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

   void _runFilterLocation(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["state"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }
  void fetchPandits()async{
    FirebaseFirestore.instance.collection('users_folder/folder/pandit_users').orderBy("pandit_joining_date",descending: true).limit(limit).get().then((value) {
      value.docs.forEach((element) {
        _allUsers.add({
                    'id':'${element.get('pandit_uid')}','name':'${element.get('pandit_name')}','age':element.get('pandit_age'),'state':element.get('pandit_state'),
                    'number':element.get('pandit_mobile_number')??'','verification':element.get('pandit_verification_status')??'','image':element.get('pandit_display_profile'),
                  });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(     
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users_folder/folder/pandit_users').orderBy("pandit_joining_date",descending: true).limit(limit).get(),          
          builder: (context, snapshot) {
            if(snapshot.data!=null){                          
                snapshot.data!.docs.forEach((element) {
                  _allUsers.add({
                    'id':'${element.get('pandit_uid')}','name':'${element.get('pandit_name')}','age':element.get('pandit_age'),'state':element.get('pandit_state'),
                    'number':element.get('pandit_mobile_number')??'','verification':element.get('pandit_verification_status')??'','image':element.get('pandit_display_profile'),
                  });
                });
             
            }
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     TextButton(onPressed: (){
                        _allUsers.clear();
                      if(location ==true){
                        setState(() {
                          location = false;
                        });
                      }
                      setState(() {
                        location = true;
                      });
                    }, child: Text( location?"Search by name":"Search by state",style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black54))),
                     SizedBox(width: 10,),
                    TextButton(
                      
                      onPressed: (){
                        _foundUsers.clear();
                      setState(() {
                        limit = limit+10;
                      });
                    }, child: Text("Icrement by 10",style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black54))),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        onChanged: (value) => location?_runFilterLocation(value) :_runFilterName(value),
                        decoration: const InputDecoration(
                            labelText: 'Search',),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _foundUsers.isNotEmpty
                      ? GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                              crossAxisCount: ResponsiveWidget.isSmallScreen(context)?2 :ResponsiveWidget.isMobileLarge(context)? 3: ResponsiveWidget.isMediumScreen(context)? 4:6,  
                              crossAxisSpacing: 4.0,  
                              mainAxisSpacing: 4.0  
                          ),                                         
                          itemCount: _foundUsers.length,
                          itemBuilder: (context, index) => InkWell(
                            hoverColor: Colors.transparent,
                            onTap: (){                            
                              Get.toNamed('/home/${AppStrings.MANAGEMENT}/pandit_users/${_foundUsers[index]["id"]}');
                            },
                            child: Card(
                              key: ValueKey(_foundUsers[index]["id"]),                       
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(5),
                                leading: CircleAvatar(
                                  maxRadius: 25,
                                  backgroundImage: NetworkImage(_foundUsers[index]["image"]),
                                ),
                                isThreeLine: true,
                                title: Text(_foundUsers[index]['name'],style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,fontSize: 18),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Age: ${_foundUsers[index]["age"].toString()} years old'),
                                        SizedBox(height: 5,),
                                         Text(
                                        'Number: ${_foundUsers[index]["number"].toString()}'),
                                        SizedBox(height: 5,),
                                         Text(
                                        'Verification: ${_foundUsers[index]["verification"].toString()}'),
                                        SizedBox(height: 5,),
                                         Text(
                                        'State: ${_foundUsers[index]["state"].toString()}'),
                          
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
        ),
      ),
    );
  }
}

