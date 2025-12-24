import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/screens/home_screen.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

extension ExGridViewProduct on HomeScreenState {
  Widget viewMasonryGrid(List<ProductItem>? listProduct) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: listProduct?.length ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: (){
              Navigator.pushNamed(
                context,
                PathRouter.productDetailScreen,
                arguments: {
                  'product': listProduct?[index],
                },
              );
            },
            child: GridItem(index: index, product: listProduct?[index]));
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  ProductItem? product;

  GridItem({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: index.isEven ? 2 / 2.8 : 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            /// ẢNH
            Positioned.fill(
              child: AppImage(
                imageUrl: product?.image ?? '', height: double.infinity, width: double.infinity,
              ),
            ),

            /// LỚP TỐI DƯỚI (để chữ dễ đọc)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
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
  final ProductItem? product;

  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        UnitText(
         text: product?.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        SizedBox(height: 4),
        UnitText(
          text: product?.price.isNotEmpty == true ? "${formatVND(int.parse("${product?.price}"))} VNĐ" : "",
          color: Colors.white,
          fontSize: 14,
          fontFamily: Assets.sfProBold,
        ),
      ],
    );
  }
}

