import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/route_manager.dart';
import 'package:management/resources/app_config.dart';
import 'package:management/screens/management/content_entry.dart';
import 'package:management/screens/member_overview/hr_documents.dart';
import 'package:management/screens/member_overview/perfomance.dart';
import 'package:management/screens/member_overview/profile.dart';
import 'package:management/screens/member_overview/work_life_cycle.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:system_theme/system_theme.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_strategy/url_strategy.dart';

import 'screens/colors.dart';
import 'screens/forms.dart';
import 'screens/management/management_zone.dart';
import 'screens/inputs.dart';
import 'screens/mobile.dart';
import 'screens/others.dart';
import 'screens/settings.dart';
import 'screens/typography.dart';
import 'theme.dart';

//const String appTitle = 'Managent Web';


bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: FluentApp(
            title: AppConfig.of(context)!.buildFlavor,
            themeMode: appTheme.mode,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {'/': (_) => const MyHomePage()},
            color: appTheme.color,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              accentColor: appTheme.color,
              visualDensity: VisualDensity.standard,
              focusTheme: FocusThemeData(
                glowFactor: is10footScreen() ? 2.0 : 0.0,
              ),
            ),
            theme: ThemeData(
              accentColor: appTheme.color,
              visualDensity: VisualDensity.standard,
              focusTheme: FocusThemeData(
                glowFactor: is10footScreen() ? 2.0 : 0.0,
              ),
            ),
            builder: (context, child) {
              return Directionality(
                textDirection: appTheme.textDirection,
                child: child!,
              );
            },
          )
          ,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;

  int index = 0;

  final settingsController = ScrollController();

  @override
  void dispose() {
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appTitle = AppConfig.of(context)!.buildFlavor;
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          if (kIsWeb) return  Text(appTitle);
          return  DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            ),
          );
        }(),
        actions: kIsWeb
            ? null
            : DragToMoveArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [Spacer(), WindowButtons()],
          ),
        ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicatorBuilder: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return NavigationIndicator.end;
            case NavigationIndicators.sticky:
            default:
              return NavigationIndicator.sticky;
          }
        }(),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.user_clapper),
            title: const Text('Profile'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.b_i_dashboard),
            title: const Text('Perfomance'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.articles),
            title: const Text('HR Documents'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.c_r_m_resource_optimization_app32),
            title: const Text('Work Life Cycle'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Manage Zone'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.icon_sets_flag),
            title: const Text('Content Entry'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.account_management),
            title: const Text('Account Manage'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.payment_card),
            title: const Text('Payments'),
          ),
          PaneItem(
            icon: const Icon(
              FluentIcons.alert_solid,
            ),
            title: const Text('Notification'),
            infoBadge: const InfoBadge(
              source: Text('9'),
            ),
          ),
        ],
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.admin),
            title: const Text('Admin Tools'),
          ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        const Profile(),
        const Perfomance(),
        const HrDocuments(),
        const Workcycle(),
        const ManageSOS(),
        const ContentEntry(),
        const InputsPage(),
        const TypographyPage(),
        const Mobile(),
        const Others(),
        Settings(controller: settingsController),
      ]),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    assert(debugCheckHasFluentLocalizations(context));
    final ThemeData theme = FluentTheme.of(context);
    final buttonColors = WindowButtonColors(
      iconNormal: theme.inactiveColor,
      iconMouseDown: theme.inactiveColor,
      iconMouseOver: theme.inactiveColor,
      mouseOver: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.hovering}),
      mouseDown: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.pressing}),
    );
    final closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red,
      mouseDown: Colors.red.dark,
      iconNormal: theme.inactiveColor,
      iconMouseOver: Colors.red.basedOnLuminance(),
      iconMouseDown: Colors.red.dark.basedOnLuminance(),
    );
    return Row(children: [
      Tooltip(
        message: FluentLocalizations.of(context).minimizeWindowTooltip,
        child: MinimizeWindowButton(colors: buttonColors),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).restoreWindowTooltip,
        child: WindowButton(
          colors: buttonColors,
          iconBuilder: (context) {
            if (appWindow.isMaximized) {
              return RestoreIcon(color: context.iconColor);
            }
            return MaximizeIcon(color: context.iconColor);
          },
          onPressed: appWindow.maximizeOrRestore,
        ),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).closeWindowTooltip,
        child: CloseWindowButton(colors: closeButtonColors),
      ),
    ]);
  }
}