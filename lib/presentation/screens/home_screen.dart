import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/widgets/common/app_loading.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'extension_screen/extension_home_child_screen.dart';
import 'extension_screen/extension_home_screen.dart';
import 'extension_screen/widget_grid_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<ProductItem> listProduct = [];
  List<StoryItem> listStory = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initLoad();
  }

  Future<void> _initLoad() async {
    AppLoading.show();
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _loadProducts();
    } finally {
      AppLoading.dismiss();
    }
  }

  Future<void> _loadProducts() async {
    listProduct = await ProductRepository.loadProducts();
    listStory = await ProductRepository.loadStory();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double iconBoxSize = width > 600 ? 88 : 66;
    final double iconImageSize = iconBoxSize * 0.62;

    return Scaffold(
      backgroundColor: AppColors.colorButtonHome,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UnitText(text: "Boom Berry", fontSize: 20, color: Colors.white, fontFamily: Assets.sfProBlackItalic),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PathRouter.loginScreen);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: UnitText(text: "Đăng nhập", fontSize: 15, color: Colors.white, fontFamily: Assets.sfProMedium),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        searchWidget(),

                        const SizedBox(height: 15),
                        listVoucherWidget(),

                        /// slider banner
                        bannerHomeWidget(),

                        /// menu grid
                        gridViewCategory(iconBoxSize, iconImageSize),

                        /// mega sale
                        viewSaleContentWidget(),
                        viewScrollHorizontalItemSaleWidget(listProduct),

                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 15),
                          child: Container(width: width, height: 10, color: Colors.grey[200]),
                        ),

                        viewMasonryGrid(listStory),

                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 15),
                          child: Container(width: width, height: 10, color: Colors.grey[200]),
                        ),

                        UnitText(text: "Danh Mục Cho Bạn", fontSize: 16, fontFamily: Assets.sfProBlackItalic),
                        const SizedBox(height: 15),

                        viewOtherGrid(listProduct),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * return Scaffold(
    backgroundColor: AppColors.colorButtonHome,
    body: SafeArea(
    bottom: false,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    /// ====== TÊN QUÁN ======
    Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    UnitText(text: "Boom Berry", fontSize: 20, color: Colors.white, fontFamily: Assets.sfProBlackItalic),

    GestureDetector(
    onTap: () {
    Navigator.pushNamed(context, PathRouter.loginScreen);
    },
    child: Container(
    color: Colors.transparent,
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: UnitText(text: "Đăng nhập", fontSize: 15, color: Colors.white, fontFamily: Assets.sfProMedium),
    ),
    ),
    ),
    ],
    ),
    ),

    /// ====== PHẦN BO GÓC ======
    Expanded(
    child: SingleChildScrollView(
    child: ClipRRect(
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
    child: Container(
    color: Colors.white,
    child: Column(
    children: [
    const SizedBox(height: 5),
    searchWidget(),

    const SizedBox(height: 15),
    listVoucherWidget(),

    /// slider banner
    bannerHomeWidget(),

    /// menu grid
    gridViewCategory(iconBoxSize, iconImageSize),

    /// mega sale
    viewSaleContentWidget(),
    viewScrollHorizontalItemSaleWidget(listProduct),

    const SizedBox(height: 15),
    UnitText(text: "Danh Mục Cho Bạn", fontSize: 16, fontFamily: Assets.sfProBlackItalic),
    const SizedBox(height: 10),

    viewSquareSaleWidget(),

    const SizedBox(height: 15),
    Container(width: width, height: 10, color: Colors.grey[200]),
    ],
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    );*/
