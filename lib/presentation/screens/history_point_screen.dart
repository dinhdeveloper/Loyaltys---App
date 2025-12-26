import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/data/models/history_point/history_point.dart';
import 'package:remindbless/presentation/widgets/common/header_delegate.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

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
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 1)); // ⏱ shimmer 1s
    final data = await loadHistoryPoints();
    if (!mounted) return;

    setState(() {
      historyPoints = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            /// HEADER PINNED
            SliverPersistentHeader(
              pinned: true,
              delegate: HeaderDelegate(title: "Lịch Sử Tích Điểm"),
            ),

            /// SHIMMER
            if (_loading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildHistoryItemShimmer(),
                  childCount: 8,
                ),
              )

            /// REAL DATA
            else ...[
              for (var day in historyPoints) ...[
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.white,
                    child: UnitText(
                      text: day.date,
                      fontSize: 13,
                      fontFamily: Assets.sfProThin,
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final item = day.items[index];
                      final isLast = index == day.items.length - 1;

                      return Column(
                        children: [
                          _buildHistoryItem(item),
                          if (isLast) const SizedBox(height: 16),
                        ],
                      );
                    },
                    childCount: day.items.length,
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // ================= REAL ITEM =================
  Widget _buildHistoryItem(HistoryItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.imgNotification3d,
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnitText(
                    text: item.title,
                    fontFamily: Assets.sfProRegular,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 5),
                  UnitText(
                    text: item.desc,
                    maxLines: 2,
                    fontFamily: Assets.sfProLight,
                  ),
                  const SizedBox(height: 5),
                  UnitText(
                    text: item.time,
                    fontSize: 15,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SHIMMER ITEM (MATCH 1–1) =================
  Widget _buildHistoryItemShimmer() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(32, 32),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerLine(width: 140, height: 14), // title
                const SizedBox(height: 10),
                _shimmerLine(height: 12),
                const SizedBox(height: 8),
                _shimmerLine(width: 180, height: 12), // desc
                const SizedBox(height: 8),
                _shimmerLine(width: 80, height: 12), // time
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerLine({double width = double.infinity, double height = 12}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _shimmerBox(double w, double h) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
