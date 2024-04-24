import 'package:ecommarce/Pages/providers/auth_provider.dart';
import 'package:ecommarce/core/constains/my_colors.dart';
import 'package:ecommarce/core/widgets/my_app_bar.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
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
            children: [
              MyAppBar(),
              _LogoSection(),
              _LoginSingUpFormSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  const _LogoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 26.0),
      child: Center(
        child: Image.asset(
          "assets/graphics/common/logo.png",
          width: 160.w,
        ),
      ),
    );
  }
}

class _LoginSingUpFormSection extends StatelessWidget {
  _LoginSingUpFormSection({super.key});

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "User Name",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        TextField(
          controller: _usernameTextController,
          decoration: InputDecoration(
            hintText: "example: mynulalam",
            fillColor: MyColors.inputBackground,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 26.0, horizontal: 18.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          "Password",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        TextField(
          controller: _passwordTextController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Your password",
            fillColor: MyColors.inputBackground,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 26.0, horizontal: 18.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) => authProvider.hasEror
              ? Center(
                  child: Text(
                  "${authProvider.errorMassege}",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ))
              : Container(),
        ),
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () async {
              //get email and password text
              String username = _usernameTextController.text;
              String password = _passwordTextController.text;
              bool isLoginSucceed =
                  await Provider.of<AuthProvider>(context, listen: false)
                      .login(username, password);
              if (isLoginSucceed) {
                context.goNamed(RouteNames.MAIN_PAGE);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, _) => authProvider.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 26.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: MyColors.secendaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
