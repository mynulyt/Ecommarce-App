import 'package:ecommarce/DataSources/token_datasource.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware {
  static Future<String?> GurdWithLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    TokenDataSource tokenDataSource = TokenDataSource(sharedPreferences);

    if ((await tokenDataSource.get()) == null) {
      return Future.value(RouteNames.LOGIN);
    }
    return null;
  }
}
