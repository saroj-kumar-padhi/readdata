import 'package:fluent_ui/fluent_ui.dart';

class Workcycle extends StatelessWidget {
  const Workcycle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(children: [
     Center(child: const Text("Workcycle"))
    ]);
  }
}