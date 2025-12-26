class Category {
  final int categoryId;
  final String categoryKey;
  final String categoryName;
  final String categoryImage;

  Category({
    required this.categoryId,
    required this.categoryKey,
    required this.categoryName,
    required this.categoryImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryKey: json['categoryKey'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
    );
  }
}
