import 'package:ecommarce/Pages/providers/cart_provider.dart';
import 'package:ecommarce/core/constains/assets_locations.dart';
import 'package:ecommarce/core/constains/my_colors.dart';
import 'package:ecommarce/core/widgets/cart_product_item.dart';
import 'package:ecommarce/core/widgets/circle_button.dart';
import 'package:ecommarce/router/rout_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartFragment extends StatelessWidget {
  const CartFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _Header(),
        _ProductsSection(),
        _BillingSection(),
      ],
    );
  }
}

// ignore: must_be_immutable
class _BillingSection extends StatelessWidget {
  _BillingSection({
    super.key,
  });
  TextEditingController _cardNumberTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Shipping Information",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.primaryColor),
            ),
            TextField(
              controller: _cardNumberTextController,
              decoration: InputDecoration(
                hintText: "Card **********876",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total (${cartProvider.totalItemCount} Items)",
                      style: TextStyle(color: MyColors.primaryColor),
                    ),
                    Text(
                      "${cartProvider.totalPrice}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "shipping fee",
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                  Text(
                    " \$10",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "sub total",
                    style: TextStyle(color: MyColors.primaryColor),
                  ),
                  Text(
                    " \$40",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  bool isPaymentSucced =
                      Provider.of<CartProvider>(context, listen: false)
                          .payNow(_cardNumberTextController.text);
                  if (!isPaymentSucced) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pament Failed"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pament Successfull!"),
                      ),
                    );
                    context.goNamed(RouteNames.MAIN_PAGE);
                  }
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
                      "Pay Now",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsSection extends StatelessWidget {
  const _ProductsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) =>
            cartProvider.items.length == 0
                ? Text("No products in cart")
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) => CartProductItem(
                      productQuantity: cartProvider.items[index],
                    ),
                  ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      sliver: SliverAppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
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
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Checkout",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
