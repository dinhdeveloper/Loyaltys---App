import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/base_screen.dart';
import 'package:remindbless/core/path_router.dart' show PathRouter;
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/ticket_common.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'package:remindbless/viewmodel/category_viewmodel.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListScreen extends BaseScreen<CategoryViewModel> {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends BaseScreenState<CategoryViewModel, CategoryListScreen>  {
  int _selectedIndex = 0;
  bool _loading = true;

  final ScrollController _categoryScrollController = ScrollController();
  late List<GlobalKey> _categoryKeys;
  List<Category> lisCategory = [];
  List<Product> filteredProducts = [];
  Category? category;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    category = args?['category'];
    lisCategory = args?['listCategory'];

    if (category != null && category?.categoryKey != null) {
      _categoryKeys = List.generate(lisCategory.length, (_) => GlobalKey());

      // Tìm index của category hiện tại
      final index = lisCategory.indexWhere((e) => e.categoryId == category?.categoryId);
      if (index != -1) _selectedIndex = index;

      getProductsByCategoryKey(category!.categoryKey);
    }
  }

  void getProductsByCategoryKey(String categoryKey){
    provider.getProductsByCategoryKey(categoryKey).then((_) {
      setState(() {
        filteredProducts = _getFilteredProducts();
        _loading = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedCategory();
      });
    });
  }

  List<Product> _getFilteredProducts() {
    if (provider.products.isEmpty) return [];

    final categoryKey = lisCategory[_selectedIndex].categoryKey;
    if (categoryKey == 'ALL') return provider.products;
    return provider.products.where((e) => e.categoryKey == categoryKey).toList();
  }

  // ---------------- AUTO SCROLL ----------------
  void _scrollToSelectedCategory() {
    final ctx = _categoryKeys[_selectedIndex].currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic, alignment: 0.5);
  }

  // ---------------- UI ----------------
  @override
  Widget buildChild(BuildContext context) {
    final bgController = context.watch<BackgroundController>();
    final currentCategory = lisCategory[_selectedIndex];
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
          child: Column(
            children: [
              _buildHeader(currentCategory.categoryName),
              _buildCategoryHorizontal(),
              const SizedBox(height: 10),
              Expanded(child: _loading ? _buildProductShimmer() : _buildProductGrid()),
            ],
          ),
        ),
        bottomNavigationBar: bottomBarDetail(onTap: () => Navigator.of(context).pop()),
      )
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: UnitText(text: title, fontSize: 18, fontFamily: Assets.sfProSemibold),
    );
  }

  // ---------------- CATEGORY BAR ----------------
  Widget _buildCategoryHorizontal() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        controller: _categoryScrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: lisCategory.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelectedCategory());
              getProductsByCategoryKey(lisCategory[index].categoryKey);
            },
            child: Container(
              key: _categoryKeys[index],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: isSelected ? AppColors.colorButtonHome : Colors.grey[100], borderRadius: BorderRadius.circular(20)),
              child: UnitText(text: lisCategory[index].categoryName, fontSize: 14, color: isSelected ? Colors.white : Colors.black87),
            ),
          );
        },
      ),
    );
  }

  // ---------------- PRODUCT GRID ----------------
  Widget _buildProductGrid() {
    if (filteredProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.iconEmptyData, width: 100),
            const SizedBox(height: 10),
            UnitText(text: 'Không có sản phẩm', fontFamily: Assets.sfProThin, fontSize: 15),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 120 / 160,
      ),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(
              context,
              PathRouter.productDetailScreen,
              arguments: {
                'product': product,
              },
            );
          },
          child: CouponCard(
            curvePosition: 145,
            curveRadius: 15,
            borderRadius: 10,
            decoration: const BoxDecoration(color: Colors.white),
            borderColor: Colors.black12,
            firstChild: _productImage(product),
            secondChild: _productInfo(product),
          ),
        );
      },
    );
  }

  // ---------------- SHIMMER GRID ----------------
  Widget _buildProductShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      itemCount: lisCategory.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 120 / 170,
      ),
      itemBuilder: (context, index) {
        return _couponCardShimmer();
      },
    );
  }

  // ---------------- PRODUCT UI ----------------
  Widget _productImage(Product product) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AppImage(imageUrl: product.imagesProduct.first.imageUrl, height: 140, width: double.infinity),
      ),
    );
  }

  Widget _productInfo(Product product) {
    final salePercent = product.productSalePercent;
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UnitText(text: product.productName, fontFamily: Assets.sfProLight, fontWeight: FontWeight.w500, fontSize: 15, maxLines: 1, overflow: TextOverflow.ellipsis),
          if (salePercent > 0)
            Row(
              children: [
                UnitText(text: "-$salePercent%", fontFamily: Assets.sfProMedium, fontSize: 12, color: Colors.green[500]),
                const SizedBox(width: 5),
                UnitText(
                  text: formatVND(product.productPrice),
                  fontFamily: Assets.sfProMedium,
                  fontSize: 12,
                  lineThrough: true,
                  color: Colors.grey,
                  lineThroughColor: Colors.grey,
                ),
              ],
            )
          else
            const SizedBox(height: 5),
          UnitText(text: "${formatVND(product.productPriceSale)} VNĐ", fontFamily: Assets.sfProMedium, fontWeight: FontWeight.w700, fontSize: 16),
        ],
      ),
    );
  }

  Widget _couponCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: CouponCard(
        curvePosition: 145,
        curveRadius: 15,
        borderRadius: 10,
        borderColor: Colors.black12,
        decoration: const BoxDecoration(color: Colors.white),

        // ---------- IMAGE ----------
        firstChild: Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(height: 140, width: double.infinity, color: Colors.white),
          ),
        ),

        // ---------- INFO ----------
        secondChild: Container(
          padding: const EdgeInsets.all(8),
          width: double.maxFinite,
          decoration: const BoxDecoration(
            border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 14, width: double.infinity, color: Colors.white),
              const SizedBox(height: 6),
              Container(height: 14, width: 90, color: Colors.white),
              const Spacer(),
              Container(height: 16, width: 110, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    super.dispose();
  }
}
