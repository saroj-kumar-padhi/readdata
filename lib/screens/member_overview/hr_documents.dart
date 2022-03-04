import 'package:fluent_ui/fluent_ui.dart';

class HrDocuments extends StatelessWidget {
  const HrDocuments({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(children: [
     Center(child: const Text("HrDocuments"))
    ]);
  }
}