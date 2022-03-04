import 'package:fluent_ui/fluent_ui.dart';

import '../../Models/management_zone_model.dart';
import '../../components/custom_grid_tabs.dart';

class ManageSOS extends StatefulWidget {
  const ManageSOS({Key? key}) : super(key: key);

  @override
  _ManageSOSState createState() => _ManageSOSState();
}

class _ManageSOSState extends State<ManageSOS> {
  String filterText = '';

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final padding = PageHeader.horizontalPadding(context);
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Management Zone'),
        commandBar: SizedBox(
          width: 240.0,
          child: Tooltip(
            message: 'Filter by name',
            child: TextBox(
              suffix: const Icon(FluentIcons.search),
              placeholder: 'Type to filter icons by name (e.g "logo")',
              onChanged: (value) => setState(() {
                filterText = value;
              }),
            ),
          ),
        ),
      ),
      bottomBar: const InfoBar(
        title: Text('Tip:'),
        content: Text(
          'You can click on any icon to copy its name to the clipboard!',
        ),
      ),
      content: GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: EdgeInsets.only(
          top: kPageDefaultVerticalPadding,
          right: padding,
          left: padding,
        ),
        children: managemntZoneDataModel
      ),
    );
  }

}

