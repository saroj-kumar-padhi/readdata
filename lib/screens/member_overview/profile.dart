import 'package:fluent_ui/fluent_ui.dart';

class Profile extends StatelessWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(children: [
     Center(child: const Text("Profile"))
    ]);
  }
}