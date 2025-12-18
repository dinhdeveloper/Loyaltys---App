class NotificationItem {
  final String id;
  final String title;
  final String desc;
  final String time;
  final String contents;

  NotificationItem({
    required this.id,
    required this.title,
    required this.desc,
    required this.time,
    required this.contents,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      time: json['time'],
      contents: json['contents'],
    );
  }
}

class NotificationDay {
  final String date;
  final String categoryId;
  final List<NotificationItem> items;

  NotificationDay({
    required this.date,
    required this.categoryId,
    required this.items,
  });

  factory NotificationDay.fromJson(Map<String, dynamic> json) {
    return NotificationDay(
      date: json['date'],
      categoryId: json['categoryId'],
      items: (json['items'] as List)
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
    );
  }
}