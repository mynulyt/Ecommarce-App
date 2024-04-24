import 'package:ecommarce/Pages/details_page/ui/details_page.dart';
import 'package:ecommarce/Pages/login_page.dart';
import 'package:ecommarce/Pages/main_page/ui/main_page.dart';
import 'package:ecommarce/model/product_model.dart';
import 'package:ecommarce/router/middlewares/auth_middleware.dart';
import 'package:go_router/go_router.dart';

class Routemanager {
  static final routeconfig = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.MAIN_PAGE,
        path: RouteNames.MAIN_PAGE,
        builder: (context, state) => const MainPage(),
        redirect: (context, state) => AuthMiddleware.GurdWithLogin(),
        routes: [
          GoRoute(
            name: RouteNames.DETAILS,
            path: RouteNames.DETAILS,
            builder: (context, state) =>
                DetailsPage(product: state.extra as ProductModel),
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.LOGIN,
        path: RouteNames.LOGIN,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}

abstract class RouteNames {
  static String MAIN_PAGE = '/main';
  static String LOGIN = '/';
  static String DETAILS = "details";
}
