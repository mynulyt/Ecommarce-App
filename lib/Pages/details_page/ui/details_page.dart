import 'package:ecommarce/Pages/providers/cart_provider.dart';
import 'package:ecommarce/core/constains/assets_locations.dart';
import 'package:ecommarce/core/constains/my_colors.dart';
import 'package:ecommarce/core/widgets/circle_button.dart';
import 'package:ecommarce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel product;
  const DetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _Header(imageUrl: product.image ?? "https://picsum.photos/200"),
              _Title(
                  title: product.title ?? "No title available",
                  product: product),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
                child: Text(
                  product.description ?? "No Description Found",
                  style:
                      TextStyle(fontSize: 16.sp, color: MyColors.inpuHintColor),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Center(child: Text("Product Added"))));
                Provider.of<CartProvider>(context, listen: false)
                    .addProduct(product);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsLocations.CARTBUY_ICON,
                    width: 32.0,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "Add to Cart | \$${product.price}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "\$190.99",
                    style: TextStyle(
                      fontSize: 10.sp,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final ProductModel product;
  final String title;
  const _Title({
    super.key,
    required this.title,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => cartProvider.removeProduct(product),
                  child: CircleButton(
                    icon: Icon(
                      Icons.remove,
                      color: MyColors.secendaryColor,
                    ),
                  ),
                ),
                Text(
                  cartProvider.CountProduct(product).toString(),
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => cartProvider.addProduct(product),
                  child: CircleButton(
                    icon: Icon(
                      Icons.add,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String imageUrl;
  const _Header({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
          width: double.infinity,
          height: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 38.0, horizontal: 44.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => context.pop(),
                child: CircleButton(
                  icon: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      AssetsLocations.BACK_ARROW,
                      width: 14.0,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 24.0,
                backgroundColor: Colors.white,
                child: Image.asset(
                  AssetsLocations.HEART_ICON,
                  width: 28.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
