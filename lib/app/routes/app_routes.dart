// import 'package:go_router/go_router.dart';

// class Routes{
//     late final GoRouter _router = GoRouter(
//     urlPathStrategy: UrlPathStrategy.path,
//     routes: <GoRoute>[
//       GoRoute(
//         path: '/',
//         redirect: (_) => '/home/${AppStrings.CONTENT_ENTRY}',
//       ),
//       GoRoute(path: '/home/:tab',
//         builder: (BuildContext context, GoRouterState state) =>
//             HomeView(
//               key: state.pageKey,
//               tab: state.params['tab']!,
//               ),
//                routes: <GoRoute>[
//                     GoRoute(
//                       path: 'client_users',
//                       builder: (BuildContext context, GoRouterState state) {                      
//                         return ClientUserList();
//                       },
//                     ),
//                     GoRoute(
//                       path: 'pandit_users',
//                       builder: (BuildContext context, GoRouterState state) {                      
//                         return PanditUserList();
//                       },
                      
//                     ),
//                     GoRoute(
//                               path: 'pandit_users/:id',
//                               builder: (BuildContext context, GoRouterState state) {                      
//                                 return PanditUserDetails(id: state.params['id']!,);
//                               })
//         ]
//             ),
//     ],
//   );
// }


