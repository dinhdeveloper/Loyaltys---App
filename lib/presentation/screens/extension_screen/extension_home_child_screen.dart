import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/screens/home_screen.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
import 'package:remindbless/presentation/widgets/common/app_image.dart';
import 'package:remindbless/presentation/widgets/common/best_seller_progress_bar.dart';
import 'package:remindbless/presentation/widgets/common/torn_paper.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import '../../widgets/common/ticket_common.dart' show CouponCard;

extension ExHomeChild on HomeScreenState {
  Widget viewSaleContentWidget() {
    return Center(
      child: TornPaper(
        width: MediaQuery.of(context).size.width,
        tearDepth: 10,
        tearFrequency: 6,
        gradientColors: [Color(0xFFFFC05E), Colors.transparent],
        roundedBottom: true,
        cornerRadius: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UnitText(text: "Giảm giá hôm nay\nKhao Lớn", fontSize: 18, fontFamily: Assets.sfProBlackItalic),
            Image.asset(Assets.imgMegaSale),
          ],
        ),
      ),
    );
  }

  Widget viewScrollHorizontalItemSaleWidget(List<ProductItem>? listProduct) {
    return SizedBox(
      height: 226,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listProduct?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: index == 0 ? 20 : 0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                  context,
                  PathRouter.productDetailScreen,
                  arguments: {
                    'product': listProduct?[index],
                  },
                );
              },
              child: CouponCard(
                height: double.infinity,
                width: 130,
                curvePosition: 120,
                curveRadius: 15,
                borderRadius: 10,
                decoration: const BoxDecoration(color: Colors.white),
                firstChild: firstChildMegaSale(listProduct?[index]),
                secondChild: secondChildMegaSale(listProduct?[index]),
                borderColor: Colors.black12,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget firstChildMegaSale(ProductItem? product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppImage(
              imageUrl: product?.image ?? '', height: 100, width: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
            child: BestSellerProgressBar(progress:  getSoldRatio(product?.soldCount), soldCount: product?.soldCount ?? 0, fillColor: Colors.lightGreenAccent, iconColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget secondChildMegaSale(ProductItem? product) {
    final salePercent = product?.salePercent ?? 0;
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UnitText(
            text: "${product?.name}",
            fontWeight: FontWeight.w200,
            fontSize: 15,
            maxLines: 1,
            overflow: TextOverflow.ellipsis
          ),
          if(salePercent > 0)
            Row(
              children: [
                UnitText(text: "-$salePercent%", fontFamily: Assets.sfProMedium, fontSize: 12, color: Colors.green[500]),
                const SizedBox(width: 5),
                UnitText(
                  text: product?.priceSale.isNotEmpty == true  ? "${formatVND(int.parse("${product?.priceSale}"))} VNĐ" : "",
                  fontFamily: Assets.sfProMedium,
                  fontSize: 12,
                  lineThrough: true,
                  color: Colors.grey,
                  lineThroughColor: Colors.grey,
                ),
              ],
            )
          else
            const SizedBox(height: 7),
          UnitText(
            text: product?.price.isNotEmpty == true ? "${formatVND(int.parse("${product?.price}"))} VNĐ" : "",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget firstChildPageForYou(ProductItem? itemSale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: AppImage(imageUrl: itemSale?.image.toString(),height: 130, width: double.infinity),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 2, right: 2),
            child: BestSellerProgressBar(progress: 0.82, soldCount: 120, fillColor: Colors.lightGreenAccent, iconColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget secondChildPageForYou(ProductItem? itemSale) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnitText(text: itemSale?.name.toString() ?? "Đồ ăn healthy buổi trưa", fontFamily: Assets.sfProMedium, fontWeight: FontWeight.w700),
          const Spacer(),
          Row(
            children: [
              UnitText(text: "-50%", fontFamily: Assets.sfProMedium, fontSize: 13, color: Colors.green[500]),
              const SizedBox(width: 5),
              UnitText(
                text: itemSale?.priceSale.isNotEmpty == true  ? "${formatVND(int.parse("${itemSale?.priceSale}"))} VNĐ" : "",
                fontFamily: Assets.sfProMedium,
                fontSize: 13,
                lineThrough: true,
                color: Colors.grey,
                lineThroughColor: Colors.grey,
              ),
            ],
          ),
          UnitText(
            text: itemSale?.price.isNotEmpty == true ? "${formatVND(int.parse("${itemSale?.price}"))} VNĐ" : "",
            fontFamily: Assets.sfProMedium,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.shadow,
  });

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;

  @override
  TicketWidgetState createState() => TicketWidgetState();
}

class TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          boxShadow: widget.shadow,
          color: widget.color,
          borderRadius: widget.isCornerRounded ? BorderRadius.circular(10.0) : BorderRadius.circular(0.0),
        ),
        child: widget.child,
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 10.0));
    path.addOval(Rect.fromCircle(center: Offset(size.width, size.height / 2), radius: 10.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
