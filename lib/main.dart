import 'package:ecommarce/Pages/providers/auth_provider.dart';
import 'package:ecommarce/Pages/providers/cart_provider.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: Routemanager.routeconfig,
          title: 'Material App',
        ),
      ),
    );
  }
}
