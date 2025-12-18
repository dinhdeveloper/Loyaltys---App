import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/data/models/history_point/history_point.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<HistoryPoint>> loadHistoryPoints() async {
  final String response = await rootBundle.loadString(DataAssets.jsonHistoryPoint);
  final data = json.decode(response);
  return (data['history'] as List).map((e) => HistoryPoint.fromJson(e)).toList();
}

class HistoryPointScreen extends StatefulWidget {
  const HistoryPointScreen({super.key});

  @override
  State<HistoryPointScreen> createState() => _HistoryPointScreenState();
}

class _HistoryPointScreenState extends State<HistoryPointScreen> {
  List<HistoryPoint> historyPoints = [];

  @override
  void initState() {
    super.initState();
    loadHistoryPoints().then((value) {
      setState(() {
        historyPoints = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // HEADER CỐ ĐỊNH
                  SliverPersistentHeader(pinned: true, delegate: _HeaderDelegate()),

                  // Lặp qua ngày
                  for (var day in historyPoints) ...[
                    // Header ngày
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        color: Colors.white,
                        child: UnitText(text: day.date, fontSize: 13, fontFamily: Assets.sfProThin),
                      ),
                    ),

                    // List items
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = day.items[index];
                        bool isLast = index == day.items.length - 1;
                        return Column(
                          children: [
                            Container(
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
                                    Image.asset(Assets.imgNotification3d, width: 32, height: 32),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          UnitText(text: item.title, fontFamily: Assets.sfProRegular, fontSize: 15, color: Colors.green),
                                          const SizedBox(height: 5),
                                          UnitText(text: item.desc, maxLines: 2, fontFamily: Assets.sfProLight),
                                          const SizedBox(height: 5),
                                          UnitText(text: item.time, fontSize: 15, color: Colors.black45),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isLast) const SizedBox(height: 16),
                          ],
                        );
                      }, childCount: day.items.length),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: const UnitText(text: "Lịch sử tích điểm", color: AppColors.colorButtonBold, fontSize: 18, fontFamily: Assets.sfProSemibold),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
