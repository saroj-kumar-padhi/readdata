import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:management/app/modules/content_entry/samagri_section/view/samagri_add_delete.dart';
import 'package:management/app/modules/management/view/pandit_user_details.dart';
import 'package:management/resources/app_strings.dart';
import 'app/modules/content_entry/puja_view/views/add_update_puja.dart';
import 'app/modules/home/view/home_view.dart';
import 'app/modules/management/view/client_users_list.dart';
import 'app/modules/management/view/pandit_users_list.dart';
import 'resources/app_themes.dart';

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    GetMaterialApp(     
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: '/home/${AppStrings.CONTENT_ENTRY}',
      getPages: [
          GetPage(name: '/home/:tab', page: ()=>HomeView(),
          children: [
           GetPage(name: '/client_users', page: ()=>ClientUserList(),           
           ),
           GetPage(name: '/pandit_users', page: ()=>PanditUserList(),
           children: [
             GetPage(name: '/:id', page: ()=>PanditUserDetails(),)
           ]
           ),
            GetPage(name: '/update_puja/:tab', page: ()=>AddUpdatePuja(),                      
           ),
           GetPage(name: '/samagri', page:()=>SamagriAddDelete())
          ]
          )
      ],
    );
}

