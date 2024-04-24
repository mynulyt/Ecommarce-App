import 'package:ecommarce/Pages/main_page/provider/home_fragment_provider.dart';
import 'package:ecommarce/core/constains/assets_locations.dart';
import 'package:ecommarce/core/constains/my_colors.dart';
import 'package:ecommarce/model/product_model.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeFragmentProvider(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: CustomScrollView(
            slivers: [
              _AppBarSec(),
              _SearchBox(),
              _CategoriesTab(),
              SliverToBoxAdapter(
                child: Consumer<HomeFragmentProvider>(
                    builder: (context, homeFragmentProvider, child) {
                  List<ProductModel> products = homeFragmentProvider.products;
                  return homeFragmentProvider.isProductLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: MyColors.primaryColor,
                          ),
                        )
                      : GridView.builder(
                          itemCount: homeFragmentProvider.products.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            childAspectRatio: 3 / 8,
                          ),
                          itemBuilder: ((context, index) => ProductCard(
                                onTap: () {
                                  context.goNamed(RouteNames.DETAILS,
                                      extra: products[index]);
                                },
                                title: (products[index].title!.length > 20
                                    ? "${products[index].title!.substring(0, 20)}..."
                                    : products[index].title ?? "No Title"),
                                category:
                                    products[index].category ?? "No Category",
                                price: "\$${products[index].price.toString()}",
                                star: "5.0",
                                image: products[index].image ??
                                    "https://picsum.photos/200/300",
                              )),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _AppBarSec() {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Welcome",
                style: TextStyle(fontSize: 18.sp),
              ),
              Text(
                "Mynul Alam",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String image;
  final String category;
  final String price;
  final String star;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.category,
    required this.price,
    required this.star,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                child: IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(image),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: MyColors.secendaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AssetsLocations.STAR_ICON,
                            width: 28,
                          ),
                          Text(
                            star,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        height: 90.0,
        child: Consumer<HomeFragmentProvider>(
          builder: (context, homeFragmentProvider, child) =>
              homeFragmentProvider.isCategoryLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeFragmentProvider.CateGories.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () =>
                            homeFragmentProvider.ChangeProductCategoryTab(
                                index),
                        child: CategoryTab(
                          icon: AssetsLocations.ALL_ITEAM,
                          title: homeFragmentProvider.CateGories[index]
                              .toString()
                              .toUpperCase(),
                          isSelected:
                              index == homeFragmentProvider.selectedTabIndex,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final String title;
  const CategoryTab({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Center(
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 18.w,
              color: isSelected ? Colors.white : MyColors.primaryColor,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: TextStyle(
                  color: isSelected ? Colors.white : MyColors.primaryColor),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: isSelected ? MyColors.primaryColor : Colors.white,
        border: Border.all(
          color: MyColors.inputBorderColor,
        ),
      ),
    );
  }
}

SliverToBoxAdapter _SearchBox() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AssetsLocations.SEARCH_ICON,
              width: 24.w,
            ),
          ),
          hintText: "Search Products",
          hintStyle: TextStyle(color: MyColors.inpuHintColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffEDEDED),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: MyColors.inputBorderColor,
              )),
        ),
      ),
    ),
  );
}
