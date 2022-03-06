import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:management/app/modules/management/view/pandit_user_details.dart';
import 'package:management/resources/app_strings.dart';
import 'app/modules/home/view/home_view.dart';
import 'app/modules/management/view/client_users_list.dart';
import 'app/modules/management/view/pandit_users_list.dart';
import 'resources/app_themes.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    GetMaterialApp(     
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      //darkTheme: Themes.dark,
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
           )
          ]
          )
      ],
    );
}

