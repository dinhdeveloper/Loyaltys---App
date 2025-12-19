import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/app_loading.dart';
import 'package:remindbless/presentation/widgets/common/best_seller_progress_bar.dart';
import 'package:remindbless/presentation/widgets/common/ticket_common.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  ProductItem? product;
  List<ProductItem> listProduct = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLoad();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    product = args?['product'];
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    listProduct = await ProductRepository.loadProducts();
  }

  Future<void> _initLoad() async {
    AppLoading.show();
    try {
      await Future.delayed(const Duration(seconds: 3));
      await _loadProducts();
    } finally {
      AppLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ====== IMAGE PRODUCT ======
          Stack(
            children: [
              AppImage(imageUrl: product?.image ?? "", height: 300, width: double.infinity),

              /// ===== BACK BUTTON =====
              Positioned (
                top: 0,
                left: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.45), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              /// ===== BO GÓC PHÍA DƯỚI IMAGE =====
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: UnitText(text: "140,000 VNĐ", fontSize: 20, fontFamily: Assets.sfProBold, maxLines: 2, color: Colors.orange),
                  ),
                ),
              ),
            ],
          ),

          /// ====== PHẦN NỘI DUNG CHÍNH ======
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return CouponCard(
                            width: constraints.maxWidth,
                            curveRadius: 20,
                            borderRadius: 10,
                            borderColor: Colors.white,
                            decoration: const BoxDecoration(color: Colors.white),
                            firstChild: productTitle(),
                            secondChild: productPrice(),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 6))],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(padding: const EdgeInsets.all(5.0), child: SvgPicture.asset(Assets.iconMinus, width: 28, height: 28)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    child: UnitText(text: "1", fontSize: 16, fontFamily: Assets.sfProMedium),
                                  ),
                                  Padding(padding: const EdgeInsets.all(5.0), child: SvgPicture.asset(Assets.iconPlus, width: 28, height: 28)),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 14.0, top: 10),
                                child: Container(width: double.infinity, height: 0.5, color: Colors.grey.shade300),
                              ),

                              UnitText(
                                fontSize: 15,
                                fontFamily: Assets.sfProLight,
                                color: Colors.black87,
                                text:
                                    "Ta tìm gì trong một tách cà phê: một chút tỉnh táo, một chút lãng du nghênh ngang ngồi lại bất động giữa phố thị cứ vồn vã trôi đi, tìm giây phút lặng yên cạnh ai đó, cái thở dài trước ngày cứ trôi qua hay một nỗi nhớ ngọt đắng vơi đầy.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 6))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 17),
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
          ),
        ],
      ),
    );
  }
}

extension WidgetDetail on _ProductDetailScreenState {
  Widget viewScrollHorizontalItemSaleWidget() {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listProduct.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: (index == 0) ? 20 : 0),
            child: CouponCard(
              height: double.infinity,
              width: 120,
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
            fontWeight: FontWeight.w700, fontSize: 14, maxLines: 2,
          ),
          const Spacer(),
          Row(
            children: [
              UnitText(text: "-50%", fontFamily: Assets.sfProMedium, fontSize: 12, color: Colors.green[500]),
              const SizedBox(width: 5),
              UnitText(
                text: product?.priceSale.isNotEmpty == true  ? formatVND(int.parse("${product?.priceSale}")) : "",
                fontFamily: Assets.sfProMedium, fontSize: 12,
                lineThrough: true, color: Colors.grey, lineThroughColor: Colors.grey,
              ),
            ],
          ),
          UnitText(
            text: product?.price.isNotEmpty == true ? "${formatVND(int.parse("${product?.price}"))} VNĐ" : "",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w700, fontSize: 14, maxLines: 1,
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
            child: AppImage(imageUrl: itemSale?.image.toString() ?? Assets.iconCoffeeCup, height: 90, width: 110),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
            child: BestSellerProgressBar(progress: 0.82, soldCount: 120, fillColor: Colors.lightGreenAccent, iconColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget productTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitText(text: "Cà phê sữa đá, Cà phê sữa đá, Cà phê sữa đá", fontSize: 18, fontFamily: Assets.sfProRegular, maxLines: 2),
          const SizedBox(height: 3),
          UnitText(
            text: "160,000 VNĐ",
            fontFamily: Assets.sfProMedium, fontSize: 16,
            lineThrough: true, color: AppColors.colorButtonHome,
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
