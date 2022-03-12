import 'package:flutter/material.dart';
import 'package:management/app/modules/content_entry/puja_view/controller/puja_add_controller.dart';

import '../app_exports.dart';

class GodCheckBox extends GetView {
  final String text;

  GodCheckBox({required this.text});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Obx(() => Column(
        children: [
          Text(text),
         const SizedBox(height: 5,),
          ListView.builder(
              itemCount: controller.god.value.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Checkbox(
                      value: controller.god.value[index]['value'],
                      onChanged: (value) {
                        controller.god.update((val) {
                          val![index]['value'] = value;
                        });
                      }),
                  title: Text(
                    "${controller.god.value[index]['type']}",
                  ),
                );
              }),
        ],
      ));
    });
  }
}
class BenefitCheckBox extends GetView {
  final String text;

  BenefitCheckBox({required this.text});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Obx(() => Column(
        children: [
           Text(text),
         const SizedBox(height: 5,),
          ListView.builder(
              itemCount: controller.benefit.value.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Checkbox(
                      value: controller.benefit.value[index]['value'],
                      onChanged: (value) {
                        controller.benefit.update((val) {
                          val![index]['value'] = value;
                        });
                      }),
                  title: Text(
                    "${controller.benefit.value[index]['type']}",
                  ),
                );
              }),
        ],
      ));
    });
  }
}

