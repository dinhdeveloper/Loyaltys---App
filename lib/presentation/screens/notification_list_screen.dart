import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            /// HEADER CỐ ĐỊNH
            SliverPersistentHeader(pinned: true, delegate: _HeaderDelegate()),

            /// DANH SÁCH SCROLL
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(Assets.imgCoffeeSignBoard, width: 35, height: 35),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              UnitText(text: "Đặt hàng thành công", fontFamily: Assets.SfProMedium, fontSize: 16),
                              SizedBox(height: 5),
                              UnitText(
                                text: "Bạn đã đặt đơn hàng mua coffee thành công, đơn hàng của bạn sẽ đến sớm nhất.",
                                maxLines: 2,
                                fontFamily: Assets.SfProLight,
                              ),
                              SizedBox(height: 5),
                              UnitText(text: "18:40 13/12/2025", fontSize: 15,color: Colors.black45),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBarDetail(
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: const UnitText(text: "Danh sách thông báo", fontSize: 20, fontFamily: Assets.SfProSemibold),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
