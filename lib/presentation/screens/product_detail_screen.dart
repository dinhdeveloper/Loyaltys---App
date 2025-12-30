import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/base_screen.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/app_loading.dart';
import 'package:remindbless/presentation/widgets/common/best_seller_progress_bar.dart';
import 'package:remindbless/presentation/widgets/common/ticket_common.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'package:remindbless/viewmodel/product_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends BaseScreen<ProductViewModel> {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends BaseScreenState<ProductViewModel, ProductDetailScreen> {
  Product? product;
  List<ProductItem> listProduct = [];

  int quantity = 1;
  double unitPrice = 0; // priceSale của 1 SP
  double totalPrice = 0;

  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    product = args?['product'];

    unitPrice = product?.productPriceSale ?? 0;
    totalPrice = unitPrice;

    _initLoad();
  }

  Future<void> _initLoad() async {
    AppLoading.show();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      listProduct = await ProductRepository.loadProducts();
      setState(() {});
    } finally {
      AppLoading.dismiss();
    }
  }

  /// ====== QTY HANDLE ======
  void _increaseQty() {
    setState(() {
      quantity++;
      totalPrice = unitPrice * quantity;
    });
  }

  void _decreaseQty() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = unitPrice * quantity;
      });
    }
  }

  @override
  Widget buildChild(BuildContext context) {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== IMAGE PRODUCT =====
            Stack(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: product?.imagesProduct.length ?? 0,
                        onPageChanged: (index) => setState(() => _currentIndex = index),
                        itemBuilder: (_, index) {
                          return AppImage(
                            imageUrl: product!.imagesProduct[index].imageUrl,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    /// DOT
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          product?.imagesProduct.length ?? 0,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentIndex == index ? 10 : 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: _currentIndex == index ? Colors.red : Colors.white70,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// BACK
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(onTap: () => Navigator.pop(context), child: _circleIcon(Icons.arrow_back_ios_new)),
                    ),
                  ),
                ),

                /// SHARE
                Positioned(
                  top: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: () {
                          SharePlus.instance.share(ShareParams(text: product?.productName ?? ""));
                        },
                        child: _circleIcon(Icons.share_outlined),
                      ),
                    ),
                  ),
                ),

                /// PRICE FLOAT
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: UnitText(
                      text: "${formatVND(product?.productPriceSale ?? 0)} VNĐ",
                      fontSize: 20,
                      fontFamily: Assets.sfProBold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),

            /// ===== CONTENT =====
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// ===== TITLE & PRICE =====
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: CouponCard(
                        width: double.infinity,
                        curveRadius: 20,
                        borderRadius: 10,
                        borderColor: Colors.white,
                        decoration: const BoxDecoration(color: Colors.white),
                        firstChild: productTitle(),
                        secondChild: productPrice(),
                      ),
                    ),

                    /// ===== QTY + DESCRIPTION =====
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: _cardDecoration(),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// QTY
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: _decreaseQty,
                                  child: SvgPicture.asset(
                                    Assets.iconMinus,
                                    width: 28,
                                    height: 28,
                                    colorFilter: quantity == 1 ? const ColorFilter.mode(Colors.grey, BlendMode.srcIn) : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: UnitText(text: "$quantity", fontSize: 16, fontFamily: Assets.sfProMedium),
                                ),
                                GestureDetector(onTap: _increaseQty, child: SvgPicture.asset(Assets.iconPlus, width: 28, height: 28)),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Divider(color: Colors.grey.shade300),

                            /// DESCRIPTION
                            UnitText(
                              fontSize: 15,
                              fontFamily: Assets.sfProLight,
                              color: Colors.black87,
                              text:
                                  "Ta tìm gì trong một tách cà phê: một chút tỉnh táo, một chút lãng du nghênh ngang ngồi lại bất động giữa phố thị...",
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// ===== SUGGEST =====
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: _cardDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: UnitText(text: "Có thể bạn sẽ thích", fontSize: 16, fontFamily: Assets.sfProMedium),
                            ),
                            viewScrollHorizontalItemSaleWidget(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: footerDetail(context),
      ),
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

extension WidgetDetail on _ProductDetailScreenState {

  /// ===== COMMON =====
  Widget _circleIcon(IconData icon) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.45), shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.withOpacity(0.15)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 6))],
    );
  }

  Widget footerDetail(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 60,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UnitText(text: "Tổng tiền", fontFamily: Assets.sfProLight, color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                UnitText(text: formatVND(totalPrice), fontSize: 20, fontFamily: Assets.sfProBold, color: Colors.orange),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PathRouter.cartScreen, arguments: {'product': product});
            },
            child: Container(
              width: 70,
              height: 90,
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.orange, Color(0xFFFFFFFF)]),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UnitText(text: "Mua", fontFamily: Assets.sfProMedium, color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17),
                    SvgPicture.asset(Assets.iconNextTop, width: 35),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewScrollHorizontalItemSaleWidget() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: (index == 0) ? 20 : 0),
            child: CouponCard(
              height: double.infinity,
              width: 125,
              curvePosition: 110,
              curveRadius: 15,
              borderRadius: 10,
              decoration: BoxDecoration(color: Colors.white),
              firstChild: firstChildMegaSale(listProduct[index]),
              borderColor: Colors.black12,
              secondChild: secondChildMegaSale(listProduct[index]),
            ),
          );
        },
      ),
    );
  }

  Widget secondChildMegaSale(ProductItem? itemSale) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitText(
            text: itemSale?.name.toString() ?? "Đồ ăn healthy buổi trưa",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            maxLines: 1,
          ),
          if (itemSale?.salePercent != 0)
            Row(
              children: [
                UnitText(text: "-${itemSale?.salePercent}%", fontFamily: Assets.sfProMedium, fontSize: 12, color: Colors.green[500]),
                const SizedBox(width: 5),
                UnitText(
                  text: "${formatVND(product?.productPriceSale ?? 0)} VNĐ",
                  fontFamily: Assets.sfProMedium,
                  fontSize: 12,
                  lineThrough: true,
                  color: Colors.grey,
                  lineThroughColor: Colors.grey,
                ),
              ],
            ),
          UnitText(
            text: "${formatVND(product?.productPrice ?? 0)} VNĐ",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget firstChildMegaSale(ProductItem? itemSale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: AppImage(imageUrl: itemSale?.image.toString() ?? Assets.iconCoffeeCup, height: 90, width: 120),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
            child: BestSellerProgressBar(
              progress: getSoldRatio(product?.productSoldCount),
              soldCount: product?.productSoldCount ?? 0,
              fillColor: Colors.lightGreenAccent,
              iconColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget productTitle() {
    final salePercent = product?.productSalePercent ?? 0;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitText(text: product?.productName, fontSize: 20, fontFamily: Assets.sfProSemibold, maxLines: 2),
          const SizedBox(height: 3),
          UnitText(
            text: (salePercent > 0) ? "${formatVND(product?.productPrice ?? 0)} VNĐ" : "",
            fontFamily: Assets.sfProMedium,
            fontSize: 16,
            lineThrough: true,
            color: AppColors.colorButtonHome,
            lineThroughColor: AppColors.colorButtonHome,
          ),
        ],
      ),
    );
  }

  Widget productPrice() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 4, top: BorderSide(color: Colors.black12, width: 2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UnitText(text: "Nhận nhiều ưu đãi hơn khi thanh toán online.", color: Colors.grey, fontSize: 15, maxLines: 2),
      ),
    );
  }
}
