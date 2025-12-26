import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/data/models/notifications/notification_item.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/header_delegate.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  List<NotificationDay> notifications = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await Future.delayed(const Duration(seconds: 1)); // ⏱ shimmer 1s
    final jsonString = await rootBundle.loadString(DataAssets.jsonNotificationList);
    final data = json.decode(jsonString);

    if (!mounted) return;

    setState(() {
      notifications =
          (data['notifications'] as List).map((e) => NotificationDay.fromJson(e)).toList();
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
              delegate: HeaderDelegate(title: "Danh Sách Thông Báo"),
            ),

            /// SHIMMER
            if (_loading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildNotificationItemShimmer(),
                  childCount: 8,
                ),
              )

            /// REAL DATA
            else
              ...notifications.map((day) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (index == 0) {
                        /// HEADER DATE
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          child: UnitText(
                            text: day.date,
                            fontSize: 13,
                            fontFamily: Assets.sfProThin,
                          ),
                        );
                      }

                      final item = day.items[index - 1];
                      final isLastItem = index == day.items.length;

                      return Column(
                        children: [
                          _buildNotificationItem(item),
                          if (isLastItem) const SizedBox(height: 10),
                        ],
                      );
                    },
                    childCount: day.items.length + 1,
                  ),
                );
              }),
          ],
        ),
      ),
      bottomNavigationBar: bottomBarDetail(
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  // ================= REAL ITEM =================
  Widget _buildNotificationItem(NotificationItem item) {
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
              Assets.imgCoffeeSignBoard,
              width: 35,
              height: 35,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnitText(
                    text: item.title,
                    fontFamily: Assets.sfProMedium,
                    fontSize: 16,
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
  Widget _buildNotificationItemShimmer() {
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
          _shimmerBox(35, 35),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerLine(width: 160, height: 15), // title
                const SizedBox(height: 8),
                _shimmerLine(height: 12),
                const SizedBox(height: 6),
                _shimmerLine(width: 200, height: 12), // desc
                const SizedBox(height: 7),
                _shimmerLine(width: 90, height: 12), // time
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

