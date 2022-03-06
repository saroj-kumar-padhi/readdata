import 'package:flutter/material.dart';

import '../app_exports.dart';
import '../responshive.dart';

class MenuBarTile extends StatelessWidget{
  const MenuBarTile({Key? key,required this.tab, required this.selectedTab, this.onTap,required this.iconData,required this.titleText}) : super(key: key);
final String selectedTab;
final VoidCallback? onTap;
final IconData iconData;
final String titleText;
final String tab;
  @override
  Widget build(BuildContext context) {
   return ListTile(     
      selected: tab == selectedTab,
      textColor: Get.isDarkMode ? Colors.white54 : Colors.black54,
      selectedColor: Get.isDarkMode ? Colors.white : Colors.black,
      onTap: onTap,
      iconColor: Get.isDarkMode ? Colors.white54 : Colors.black54,
      leading: Icon(
        iconData,
      ),
      title: ResponsiveWidget.isLargeScreen(context) ? Text(titleText) : null,
    );     
  }

}