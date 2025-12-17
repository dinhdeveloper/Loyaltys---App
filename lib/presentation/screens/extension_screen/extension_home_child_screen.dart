import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/data/models/data_home.dart';
import 'package:remindbless/presentation/screens/home_screen.dart';
import 'package:remindbless/presentation/utils/formatters.dart';
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
        gradientColors: [Color(0xFFFFC05E), Colors.grey.shade100],
        roundedBottom: true,
        cornerRadius: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UnitText(text: "Mega Sale Thứ 4\nKhao Lớn", fontSize: 18, fontFamily: Assets.SfProBlackItalic),
            Image.asset(Assets.imgMegaSale),
          ],
        ),
      ),
    );
  }

  Widget viewScrollHorizontalItemSaleWidget() {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jsonMegaSale['items']?.length ?? 0,
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
              firstChild: firstChildMegaSale(jsonMegaSale['items']?[index]),
              borderColor: Colors.grey,
              secondChild: secondChildMegaSale(jsonMegaSale['items']?[index]),
            ),
          );
        },
      ),
    );
  }

  Widget secondChildMegaSale(Map<String, Object>? itemSale) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        UnitText(text: itemSale?['title'].toString() ?? "Đồ ăn healthy buổi trưa",fontFamily: Assets.SfProMedium, fontWeight: FontWeight.w700, fontSize: 14, maxLines: 2),
        const Spacer(),
        Row(children: [
          UnitText(text: itemSale?['discount'].toString() ?? "-50%",fontFamily: Assets.SfProMedium, fontSize: 12,color: Colors.green[500]),
          const SizedBox(width: 5),
          UnitText(text: formatVND(int.parse(itemSale?['oldPrice'].toString() ?? "0")),fontFamily: Assets.SfProMedium, fontSize: 12, lineThrough: true, color: Colors.grey, lineThroughColor:Colors.grey ),
        ]),
            UnitText(text: "${formatVND(int.parse(itemSale?['price'].toString() ?? "0"))} VNĐ",fontFamily: Assets.SfProMedium, fontWeight: FontWeight.w700, fontSize: 14, maxLines: 1),
      ]),
    );
  }

  Widget firstChildMegaSale(Map<String, Object>? itemSale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(itemSale?['imageUrl'].toString() ?? Assets.iconCoffeeCup, fit: BoxFit.cover, height: 90, width: 90),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
            child: BestSellerProgressBar(progress: 0.82, soldCount: 120, fillColor: Colors.lightGreenAccent, iconColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget firstChildPageForYou(Map<String, Object>? itemSale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(itemSale?['imageUrl'].toString() ?? Assets.iconCoffeeCup, fit: BoxFit.cover, height: 130, width: double.infinity),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 2, right: 2),
            child: BestSellerProgressBar(progress: 0.82, soldCount: 120, fillColor: Colors.lightGreenAccent, iconColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget secondChildPageForYou(Map<String, Object>? itemSale) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        border: DashedBorder(dashLength: 2, top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UnitText(text: itemSale?['title'].toString() ?? "Đồ ăn healthy buổi trưa",fontFamily: Assets.SfProMedium, fontWeight: FontWeight.w700),
            const Spacer(),
            Row(children: [
              UnitText(text: itemSale?['discount'].toString() ?? "-50%",fontFamily: Assets.SfProMedium, fontSize: 13,color: Colors.green[500]),
              const SizedBox(width: 5),
              UnitText(text: formatVND(int.parse(itemSale?['oldPrice'].toString() ?? "0")),fontFamily: Assets.SfProMedium, fontSize: 13, lineThrough: true, color: Colors.grey, lineThroughColor:Colors.grey ),
            ]),
            UnitText(text: "${formatVND(int.parse(itemSale?['price'].toString() ?? "0"))} VNĐ",fontFamily: Assets.SfProMedium, fontWeight: FontWeight.w700),
          ]),
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
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
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
