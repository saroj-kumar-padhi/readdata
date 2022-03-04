import 'package:fluent_ui/fluent_ui.dart';

import '../components/custom_grid_tabs.dart';

List<CustomGridTabs> managemntZoneDataModel = [
  CustomGridTabs(tabText: "Users",tip: "user",iconData: FluentIcons.user_window,tap: (){},),
  CustomGridTabs(tabText: "Pandits",tip: "pandits",iconData: FluentIcons.user_clapper,tap: (){},),
  CustomGridTabs(tabText: "Support Chat",tip: "Support",iconData: FluentIcons.chat_bot,tap: (){},),
  CustomGridTabs(tabText: "Refund",tip: "Refund",iconData: FluentIcons.currency,tap: (){},),
  CustomGridTabs(tabText: "Complaint",tip: "Logged Complain",iconData: FluentIcons.block_contact,tap: (){},)
];


List<CustomGridTabs> contentEntryDataModel = [
  CustomGridTabs(tabText: "Puja",tip: "List Pujar",iconData: FluentIcons.background_color,tap: (){},),
  CustomGridTabs(tabText: "Samagri",tip: "List Samagri",iconData: FluentIcons.backlog_board,tap: (){},),
  CustomGridTabs(tabText: "Puja Steps",tip: "List Pujan Steps",iconData: FluentIcons.clipboard_list,tap: (){},),
  CustomGridTabs(tabText: "Calender",tip: "Update festival calender",iconData: FluentIcons.calendar_settings,tap: (){},),
  CustomGridTabs(tabText: "Muhurat",tip: "Add Muhurar",iconData: FluentIcons.calendar_reply,tap: (){},)
];