import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget{


  final String appTitle;
  final String buildFlavor;
  final Widget child;

  AppConfig({
    Key? key,
    required this.child,
    required this.appTitle,
    required this.buildFlavor,

  }) : super(child: child);



  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}