import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/screens/extension_screen/extension_home_two_screen.dart';
import 'package:remindbless/presentation/screens/extension_screen/widget_product_card_home.dart';
import 'package:remindbless/presentation/widgets/common/app_loading.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'extension_screen/extension_home_child_screen.dart';
import 'extension_screen/extension_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  //late final PageController pagaProductController;
  final tabs = ["Ưu đãi đỉnh", "Dành cho bạn"];
  List<ProductItem> listProduct = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLoad();
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // preload banner
    for (final img in banners) {
      precacheImage(AssetImage(img), context);
    }

    // preload category icon
    for (final img in itemsHomeCategory) {
      precacheImage(AssetImage(img.assetPath), context);
    }
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

  Future<void> _loadProducts() async {
    listProduct = await ProductRepository.loadProducts();
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                child: Container(
                  color: Colors.white,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: NestedScrollView(
                      headerSliverBuilder: (context, inner) {
                        return [
                          SliverToBoxAdapter(
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

                          /// TAB BAR GHIM
                          SliverAppBar(
                            backgroundColor: Colors.white,
                            pinned: true,
                            toolbarHeight: 0,
                            elevation: 0,
                            bottom: TabBar(
                              controller: tabController,
                              labelColor: AppColors.colorButtonHome,
                              unselectedLabelColor: Colors.black54,
                              indicatorColor: AppColors.colorButtonHome,
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                            ),
                          ),
                        ];
                      },

                      /// TAB VIEW
                      body: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [viewPageForYou(listProduct), viewPageForYou(listProduct)],
                      ),
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

  @override
  void dispose() {
    tabController.dispose();
    //pagaProductController.dispose();
    super.dispose();
  }
}

/**
 * Center(
    child: SizedBox(
    height: 300,
    child: PageView.builder(
    controller: pagaProductController,
    itemCount: _products.length,
    itemBuilder: (context, index) {
    return AnimatedBuilder(
    animation: pagaProductController,
    builder: (context, child) {
    double scale = 2.0;
    double translateY = 0.0;

    if (pagaProductController.position.haveDimensions) {
    final page = pagaProductController.page ?? 1;
    final diff = (page - index).abs();

    scale = (1 - diff * 0.5).clamp(0.9, 1.0);
    translateY = diff * 5;
    }

    return Transform.translate(
    offset: Offset(0, translateY),
    child: Transform.scale(
    scale: scale,
    child: child,
    ),
    );
    },
    child: WidgetProductCardHome(item: _products[index]),
    );
    },
    ),
    ),
    ),
 * */
