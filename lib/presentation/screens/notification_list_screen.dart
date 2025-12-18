import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/data/models/notifications/notification_item.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  List<NotificationDay> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final jsonString = await rootBundle.loadString(DataAssets.jsonNotificationList);
    final data = json.decode(jsonString);
    setState(() {
      notifications = (data['notifications'] as List).map((e) => NotificationDay.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: notifications.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              bottom: false,
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(pinned: true, delegate: _HeaderDelegate()),
                  ...notifications.map((day) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index == 0) {
                          // Header ngày
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                            child: UnitText(text: day.date, fontSize: 13, fontFamily: Assets.sfProThin),
                          );
                        }
                        final item = day.items[index - 1]; // vì index 0 là header
                        final isLastItem = index == day.items.length;
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
                                    Image.asset(Assets.imgCoffeeSignBoard, width: 35, height: 35),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          UnitText(text: item.title, fontFamily: Assets.sfProMedium, fontSize: 16),
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
                            if (isLastItem) const SizedBox(height: 10),
                          ],
                        );
                      }, childCount: day.items.length + 1), // +1 cho header
                    );
                  }),
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
      child: const UnitText(text: "Danh sách thông báo", color: AppColors.colorButtonBold, fontSize: 20, fontFamily: Assets.sfProSemibold),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
