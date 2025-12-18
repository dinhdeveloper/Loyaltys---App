class HistoryPoint {
  final String categoryId; // id của ngày/category
  final String date;
  final List<HistoryItem> items;

  HistoryPoint({
    required this.categoryId,
    required this.date,
    required this.items,
  });

  factory HistoryPoint.fromJson(Map<String, dynamic> json) {
    return HistoryPoint(
      categoryId: json['categoryId'],
      date: json['date'],
      items: (json['items'] as List)
          .map((e) => HistoryItem.fromJson(e))
          .toList(),
    );
  }
}

class HistoryItem {
  final String id; // id riêng của item
  final String title;
  final String desc;
  final String time;
  final String contents;

  HistoryItem({
    required this.id,
    required this.title,
    required this.desc,
    required this.time,
    required this.contents,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      time: json['time'],
      contents: json['contents'],
    );
  }
}
