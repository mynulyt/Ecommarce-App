import 'package:ecommarce/DataSources/token_datasource.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.goNamed(RouteNames.MAIN_PAGE);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Home Page",
              ),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    TokenDataSource tokenDataSource =
                        TokenDataSource(sharedPreferences);
                    if (await tokenDataSource.delete()) {
                      print("Logged Out");
                    } else {
                      print("Logged Out failed");
                    }
                    context.goNamed(RouteNames.LOGIN);
                  },
                  child: Text("Log Out"))
            ],
          ),
        ),
      ),
    );
  }
}
