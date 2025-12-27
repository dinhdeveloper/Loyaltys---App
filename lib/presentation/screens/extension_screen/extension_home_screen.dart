import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/presentation/screens/home_screen.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'package:remindbless/viewmodel/category_viewmodel.dart';

extension ExHomeScreen on HomeScreenState{
  Widget searchWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UnitText(
                text: "Chào Buổi Sáng",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: Assets.sfProMediumItalic,
              ),
              const SizedBox(width: 4),
              UnitText(
                text: "DinhTC",
                fontSize: 16,
                fontWeight: FontWeight.w900,
                fontFamily: Assets.sfProMediumItalic,
              ),
            ],
          ),

          /// ===== ICON RIGHT =====
          Row(
            children: [
              /// CART
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                    context,
                    PathRouter.cartScreen,
                  );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(Assets.iconCartHome),
                    Positioned(
                      top: -3,
                      right: -3,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.white, width: 1.5),
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: const Center(
                          child: Text(
                            '6',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// NOTI
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, PathRouter.notificationListScreen);
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(Assets.iconNoti),
                    Positioned(
                      top: -3,
                      right: -3,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.white, width: 1.5),
                          ),
                        ),
                        constraints:
                        const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listVoucherWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.iconGift, color: Colors.grey, width: 20,height: 20),
                    const SizedBox(width: 5),
                    UnitText(text: "18", fontWeight: FontWeight.w500, fontFamily: Assets.sfProMedium),
                  ],
                ),
              ),

              // Badge với số
              Positioned(
                top: -3,
                right: -1,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(Assets.iconWallet, color: Colors.grey, width: 20, height: 20),
                const SizedBox(width: 5),
                UnitText(
                  text: "128.914.999",
                  fontWeight: FontWeight.w500,
                  fontFamily: Assets.sfProMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerHomeWidget() {
    return CarouselSlider(
      items: banners.map((img) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }

  Widget gridViewCategory(double iconBoxSize, double iconImageSize) {
    // Lấy category từ ViewModel
    final vm = context.watch<CategoryViewModel>();
    final categories = vm.categories; // giả sử bạn đã load danh sách category trong VM

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.77,
        children: categories.map((it) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PathRouter.categoryListScreen,
                arguments: {
                  'category': it,
                  'listCategory': categories,
                },
              );
            },
            child: IconTile(
              idCategory: "${it.categoryId}",
              assetPath: it.categoryImage, // API trả ra URL đầy đủ
              label: it.categoryName,
              boxSize: iconBoxSize,
              imageSize: iconImageSize,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String idCategory;
  final String assetPath;
  final String label;
  final double boxSize;
  final double imageSize;

  const IconTile({super.key,
    required this.idCategory,
    required this.assetPath,
    required this.label,
    required this.boxSize,
    required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon box with shadow and rounded corners
        Container(
          width: boxSize,
          height: boxSize,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: AppImage(
            imageUrl: assetPath,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        // Label (2 dòng nếu cần)
        UnitText(
          text: label,
          textAlign: TextAlign.center,
          height: 1.18,
          maxLines: 2,
          fontSize: 13,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
