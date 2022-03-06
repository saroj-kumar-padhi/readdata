import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:management/app/modules/management/view/pandit_user_details.dart';
import 'package:management/resources/app_strings.dart';
import 'app/modules/home/view/home_view.dart';
import 'app/modules/management/view/client_users_list.dart';
import 'app/modules/management/view/pandit_users_list.dart';
import 'resources/app_themes.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    GetMaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
    );

  late final GoRouter _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        redirect: (_) => '/home/${AppStrings.CONTENT_ENTRY}',
      ),
      GoRoute(path: '/home/:tab',
        builder: (BuildContext context, GoRouterState state) =>
            HomeView(
              key: state.pageKey,
              tab: state.params['tab']!,
              ),
               routes: <GoRoute>[
                    GoRoute(
                      path: 'client_users',
                      builder: (BuildContext context, GoRouterState state) {                      
                        return ClientUserList();
                      },
                    ),
                    GoRoute(
                      path: 'pandit_users',
                      builder: (BuildContext context, GoRouterState state) {                      
                        return PanditUserList();
                      },
                      
                    ),
                    GoRoute(
                              path: 'pandit_users/:id',
                              builder: (BuildContext context, GoRouterState state) {                      
                                return PanditUserDetails(id: state.params['id']!,);
                              })
        ]
            ),
    ],
  );
}

