import 'package:fluent_ui/fluent_ui.dart';

class Perfomance extends StatelessWidget {
  const Perfomance({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(children: [
     Center(child: const Text("Perfomance"))
    ]);
  }
}