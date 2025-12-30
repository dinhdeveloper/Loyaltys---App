import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  final List<Map<String, dynamic>> recentSearches = const [
    {"query": "Turkish Coffee", "count": "128"},
    {"query": "Vietnamese Coffee", "count": "56"},
    {"query": "Irish Coffee", "count": "89"},
  ];

  final List<Map<String, dynamic>> popularCategories = const [
    {"name": "Espresso", "books": "1.2K"},
    {"name": "Americano", "books": "890"},
    {"name": "Cappuccino", "books": "2.1K"},
    {"name": "Latte", "books": "456"},
    {"name": "Flat White", "books": "678"},
    {"name": "Macchiato", "books": "543"},
    {"name": "Affogato", "books": "124"},
    {"name": "Cortado", "books": "256"},
    {"name": "Ristretto", "books": "574"},
    {"name": "Iced Coffee", "books": "232"},
    {"name": "Cold Brew", "books": "501"},
    {"name": "Frappé", "books": "245"},
    {"name": "Doppio", "books": "987"},
    {"name": "Mocha", "books": "122"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// ===== SEARCH BOX (KHÔNG SCROLL) =====
            SliverPersistentHeader(pinned: true, delegate: SearchHeaderDelegate(child: _buildSearchBox(context))),

            /// ===== RECENT SEARCH =====
            SliverToBoxAdapter(
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: _buildRecentSearches(context)),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            /// ===== SUGGEST FOR YOU =====
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: UnitText(
                  text: 'Gợi ý cho bạn',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: Assets.sfProMedium,
                ),
              ),
            ),

            /// ===== POPULAR CATEGORIES =====
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                      _buildCategoryItem(popularCategories[index], index, context),
                  childCount: popularCategories.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 3.0,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 70)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(42),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: AppColors.colorText, size: 20),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                style: TextStyle(color: AppColors.colorText, fontSize: 15, fontFamily: Assets.sfProRegular),
                decoration: InputDecoration(
                  hintText: 'Search coffee...',
                  hintStyle: TextStyle(color: AppColors.colorText, fontFamily: Assets.sfProRegular),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                cursorColor: AppColors.colorText,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Xử lý filter
                _showFilterOptions(context);
              },
              child: CommonGlass(
                blur: 20,
                width: 30,
                height: 30,
                radius: 15,
                child: Icon(Icons.tune, color: AppColors.colorText.withOpacity(0.7), size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UnitText(
            text: 'Tìm kiếm gần đây', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: Assets.sfProMedium
          ),
        ),
        const SizedBox(height: 15),
        ...recentSearches.asMap().entries.map((entry) => _buildRecentSearchItem(context, entry.value, entry.key)),
      ],
    );
  }

  Widget _buildRecentSearchItem(BuildContext context, Map<String, dynamic> search, int index) {
    return GestureDetector(
      onTap: () {
        // Xử lý khi chọn recent search
        _handleRecentSearchTap(search['query']);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CommonGlass(
          height: 55,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.history, color: Colors.black.withOpacity(0.9), size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: UnitText(text: search['query'],
                      color: Colors.black, fontSize: 14, fontFamily: Assets.sfProRegular
                  ),
                ),
                CommonGlass(
                  radius: 20,
                  blur: 10,
                  width: 45,
                  height: 28,
                  colorBlur: Colors.white12,
                  child: UnitText(text: '${search['count']}+',
                      color: Colors.black.withOpacity(0.9), fontSize: 12, fontFamily: Assets.sfProRegular
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã thêm đơn hàng ${category['name']} vào giỏ hàng'),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: CommonGlass(
        height: 55,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnitText(text: category['name'],
                    color: Colors.black, fontSize: 14, fontFamily: Assets.sfProRegular
                ),
                CommonGlass(
                  blur: 5, width: 40, height: 25, radius: 20,
                  colorBlur: Colors.white12,
                  child: UnitText(text: category['books'],
                      color: Colors.black, fontSize: 10, fontFamily: Assets.sfProRegular
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CommonGlass(
          radius: 15,
          blur: 20,
          paddingChild: 20,
          colorBlur: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bộ lọc tìm kiếm',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: Assets.sfProMedium),
              ),
              const SizedBox(height: 20),
              // Thêm các option filter ở đây
              _buildFilterOption('Thể loại', Icons.category),
              _buildFilterOption('Tác giả', Icons.person),
              _buildFilterOption('Năm xuất bản', Icons.calendar_today),
              _buildFilterOption('Giá tiền', Icons.attach_money),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('Áp dụng bộ lọc', style: TextStyle(fontFamily: Assets.sfProMedium)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: Colors.black.withOpacity(0.7), size: 20),
          const SizedBox(width: 12),
          UnitText(text: title, color: Colors.black, fontSize: 16, fontFamily: Assets.sfProRegular),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.black.withOpacity(0.5), size: 16),
        ],
      ),
    );
  }

  void _handleRecentSearchTap(String query) {
    // Xử lý khi chọn recent search
    print('Selected search: $query');
  }

  void _handleCategoryTap(String category) {
    // Xử lý khi chọn category
    print('Selected category: $category');
  }
}

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SearchHeaderDelegate({required this.child, this.height = 84});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.transparent, padding: const EdgeInsets.fromLTRB(20, 20, 20, 10), child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
