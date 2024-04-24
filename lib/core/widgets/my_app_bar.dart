import 'package:ecommarce/Pages/providers/auth_provider.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../constains/my_colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Welcome",
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              "Lets Login or Signup",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        InkWell(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/graphics/common/avater.png"),
            ),
            onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 12.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isSucceed = await Provider.of<AuthProvider>(
                                  context,
                                  listen: false)
                              .logout();
                          if (isSucceed) {
                            context.goNamed(RouteNames.LOGIN);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                        ),
                        child: Text("Logut"),
                      ),
                    ),
                  ),
                ))
      ],
    );
  }
}
