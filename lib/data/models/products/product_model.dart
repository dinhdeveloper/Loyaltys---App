class Product {
  final int productId;
  final int categoryId;
  final String categoryKey;
  final String productName;
  final String productImage;
  final double productPrice;
  final double productPriceSale;
  final int productSalePercent;
  final int productSoldCount;
  final String productLocationSale;

  Product({
    required this.productId,
    required this.categoryId,
    required this.categoryKey,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productPriceSale,
    required this.productSalePercent,
    required this.productSoldCount,
    required this.productLocationSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as int,
      categoryId: json['categoryId'] as int,
      categoryKey: json['categoryKey'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productPriceSale: (json['productPriceSale'] as num).toDouble(),
      productSalePercent: json['productSalePercent'] as int,
      productSoldCount: json['productSoldCount'] as int,
      productLocationSale: json['productLocationSale'] as String,
    );
  }
}
