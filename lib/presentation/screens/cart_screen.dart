import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/header_delegate.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final bgController = context.watch<BackgroundController>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bgController.background,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              /// ===== HEADER PINNED =====
              SliverPersistentHeader(pinned: true, delegate: HeaderDelegate(title: "Giỏ Hàng")),

              /// ===== CART LIST =====
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(delegate: SliverChildBuilderDelegate((context, index) => _cartItem(index: index), childCount: 10)),
              ),
            ],
          ),
        ),

        /// ===== BOTTOM CHECKOUT =====
        bottomNavigationBar: _bottomCheckout(),
      ),
    );
  }

  /// ================= CART ITEM =================
  Widget _cartItem({required int index}) {
    return Dismissible(
      key: ValueKey(index),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const UnitText(
          text: "Xóa",
          color: Colors.white,
          fontSize: 16,
          fontFamily: Assets.sfProMedium,
        ),
      ),
      onDismissed: (_) {
        // TODO: remove item khỏi list
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: CommonGlass(
          height: 105,
          //margin: const EdgeInsets.only(bottom: 12),
          paddingChild: 8,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(12),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.09),
          //       blurRadius: 10,
          //       offset: const Offset(0, 4),
          //     ),
          //   ],
          // ),
          child: Row(
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage(
                  imageUrl:
                  "https://images.unsplash.com/photo-1678016935857-396bfff65aae",
                  width: 80,
                  height: 80,
                ),
              ),

              const SizedBox(width: 12),

              /// INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UnitText(
                      text: "Cà phê sữa đá",
                      fontFamily: Assets.sfProLight,
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Row(
                      children: const [
                        UnitText(
                          text: "25.000đ",
                          fontSize: 16,
                          color: Colors.orange,
                          fontFamily: Assets.sfProBold,
                        ),
                        SizedBox(width: 8),
                        UnitText(
                          text: "35.000đ",
                          fontSize: 13,
                          color: Colors.grey,
                          lineThrough: true,
                          fontFamily: Assets.sfProRegular,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    /// QUANTITY
                    Row(
                      children: [
                        _qtyButton(
                          icon: Icons.remove,
                          onTap: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: UnitText(
                            text: "$quantity",
                            fontSize: 15,
                            fontFamily: Assets.sfProMedium,
                          ),
                        ),
                        _qtyButton(
                          icon: Icons.add,
                          onTap: () {
                            setState(() => quantity++);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  /// ================= BOTTOM CHECKOUT =================
  Widget _bottomCheckout() {
    return CommonGlass(
      height: 105,
      colorBlur: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              /// TOTAL
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  UnitText(text: "Tổng thanh toán", fontSize: 13, color: Colors.white),
                  SizedBox(height: 4),
                  UnitText(text: "75.000đ", fontSize: 18, color: Colors.orange, fontFamily: Assets.sfProBold),
                ],
              ),

              const Spacer(),

              /// CHECKOUT BUTTON
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: const UnitText(text: "Thanh toán", color: Colors.white, fontSize: 15, fontFamily: Assets.sfProMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
