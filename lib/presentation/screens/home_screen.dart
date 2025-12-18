import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/presentation/screens/extension_screen/extension_home_two_screen.dart';
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
  final tabs = ["Dành cho bạn", "Ưu đãi đỉnh"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final img in banners) {
      precacheImage(AssetImage(img), context);
    }

    for (final img in itemsHomeCategory) {
      precacheImage(AssetImage(img.assetPath), context);
    }
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
                  UnitText(text: "BoomBerry Coffee", fontSize: 20, color: Colors.white, fontFamily: Assets.sfProBlackItalic),

                  GestureDetector(
                    onTap: () {
                      context.push(PathRouter.loginScreen);
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
                                viewScrollHorizontalItemSaleWidget(),

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
                              labelColor: Colors.blueAccent,
                              unselectedLabelColor: Colors.black54,
                              indicatorColor: Colors.blueAccent,
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                            ),
                          ),
                        ];
                      },

                      /// TAB VIEW
                      body: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [viewPageForYou(), viewPageForYou()],
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
    super.dispose();
  }
}
