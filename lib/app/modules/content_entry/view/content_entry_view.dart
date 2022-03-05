import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../resources/app_components/function_cards.dart';

class ContentEntryView extends StatelessWidget{
  final String id;
  ContentEntryView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Wrap(
          children: const[
          FunctionCards(iconData: CupertinoIcons.bolt_horizontal_circle ,text: 'Puja',),
          FunctionCards(iconData: CupertinoIcons.archivebox,text: 'Samagri',),
          FunctionCards(iconData: CupertinoIcons.calendar,text: 'Calender',),
          FunctionCards(iconData: CupertinoIcons.calendar_today ,text: 'Muhurat',),

          ],
        )
      )
    );
  }

}

