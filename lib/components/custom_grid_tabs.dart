import 'package:fluent_ui/fluent_ui.dart';

class CustomGridTabs extends StatelessWidget{
  final String tip;
  final String tabText;
  final IconData iconData;
  final VoidCallback? tap;
  const CustomGridTabs({Key? key, required this.tabText, 
  this.tap, required this.tip, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  HoverButton(
          onPressed: () async {
            // final copyText = 'FluentIcons.${e.key}';
            // await FlutterClipboard.copy(copyText);
            // showCopiedSnackbar(context, copyText);
          },
          builder: (context, states) {
            return FocusBorder(
              focused: states.isFocused,
              child: Tooltip(
                useMousePosition: false,
                message:tip,
                child: RepaintBoundary(
                  child: AnimatedContainer(
                    duration: FluentTheme.of(context).fasterAnimationDuration,
                    decoration: BoxDecoration(
                      color: ButtonThemeData.uncheckedInputColor(
                        FluentTheme.of(context),
                        states,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Icon(iconData, size: 40),
                         Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            tabText,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }

}