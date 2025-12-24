import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/screens/home_screen.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/ticket_common.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

extension ExGridViewProduct on HomeScreenState {
  Widget viewMasonryGrid(List<StoryItem>? listProduct) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: listProduct?.length ?? 4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PathRouter.productDetailScreen, arguments: {'product': listProduct?[index]});
          },
          child: GridItem(index: index, product: listProduct?[index]),
        );
      },
    );
  }

  Widget viewOtherGrid(List<ProductItem>? listProduct) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: listProduct?.length ?? 0,
      itemBuilder: (context, index) {
        final product = listProduct?[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PathRouter.productDetailScreen, arguments: {'product': product});
          },
          child: CouponCard(
            height: 234,
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

  Widget _productImage(ProductItem? product) {
    final salePercent = product?.salePercent ?? 0;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            /// IMAGE
            AppImage(imageUrl: product?.image, height: 140, width: double.infinity),

            /// SALE BADGE
            if (salePercent > 0) Positioned(top: 5, right: 5, child: _saleBadge(salePercent)),
          ],
        ),
      ),
    );
  }

  Widget _saleBadge(int salePercent) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: UnitText(text: "-$salePercent%", fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white, textAlign: TextAlign.center),
    );
  }

  Widget _productInfo(ProductItem? product) {
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
          UnitText(text: product?.name, fontFamily: Assets.sfProLight, fontWeight: FontWeight.w500, fontSize: 14, maxLines: 2),
          UnitText(
            text: product?.priceSale.isNotEmpty == true ? "${formatVND(int.parse("${product?.priceSale}"))} VNĐ" : "",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  StoryItem? product;

  GridItem({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: index.isEven ? 2 / 2.2 : 3 / 2.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            /// ẢNH
            Positioned.fill(
              child: AppImage(imageUrl: product?.image ?? '', height: double.infinity, width: double.infinity),
            ),

            /// LỚP TỐI DƯỚI (để chữ dễ đọc)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.black54),
                child: _ProductInfo(product: product),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final StoryItem? product;

  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return UnitText(
      text: product?.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
  }
}
