import 'package:ecommarce/Pages/main_page/provider/main_page_provider.dart';
import 'package:ecommarce/Pages/main_page/ui/cart_fragment.dart';
import 'package:ecommarce/Pages/main_page/ui/fragments/home_fragments.dart';
import 'package:ecommarce/Pages/main_page/ui/fragments/wish_list__fragment.dart';
import 'package:ecommarce/core/constains/assets_locations.dart';
import 'package:ecommarce/core/constains/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      builder: (context, child) => Scaffold(
        body: Consumer<MainPageProvider>(
          builder: (context, mainPageProvider, child) {
            if (mainPageProvider.getSelectedTab() == 0) {
              return HomeFragment();
            }
            if (mainPageProvider.getSelectedTab() == 1) {
              return CartFragment();
            }
            if (mainPageProvider.getSelectedTab() == 2) {
              return WishListFragment();
            }
            return Center(
              child: Text("No Fragment Selected"),
            );
          },
        ),
        bottomNavigationBar: Consumer<MainPageProvider>(
          builder: (context, mainPageProvider, child) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Theme(
              data: Theme.of(context)
                  .copyWith(canvasColor: MyColors.primaryColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: mainPageProvider.getSelectedTab(),
                    onTap: (index) => mainPageProvider.setTab(index),
                    items: [
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            width: 44.0,
                            height: 44.0,
                            child: Image.asset(AssetsLocations.HOME_ICON),
                          ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            width: 44.0,
                            height: 44.0,
                            child: Image.asset(AssetsLocations.CART_ICON),
                          ),
                          label: "Card"),
                      BottomNavigationBarItem(
                          icon: SizedBox(
                            width: 44.0,
                            height: 44.0,
                            child: Image.asset(AssetsLocations.WISHLIST_ICON),
                          ),
                          label: "Wish List"),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
