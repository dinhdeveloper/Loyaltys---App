class Product {
  final int productId;
  final String productName;
  final double productPrice;
  final double productPriceSale;
  final int productSalePercent;
  final int productSoldCount;
  final String productLocationSale;
  final String categoryKey;
  final List<ImageProduct> imagesProduct;

  /// tiện lấy ảnh chính
  String get primaryImage =>
      imagesProduct
          .firstWhere(
            (e) => e.isPrimary,
        orElse: () => imagesProduct.isNotEmpty
            ? imagesProduct.first
            : ImageProduct(id: 0, imageUrl: '', isPrimary: false),
      )
          .imageUrl;

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productPriceSale,
    required this.productSalePercent,
    required this.productSoldCount,
    required this.productLocationSale,
    required this.categoryKey,
    required this.imagesProduct,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: (json['productId'] ?? 0) as int,
      productName: json['productName'] ?? '',
      productPrice: (json['productPrice'] as num?)?.toDouble() ?? 0.0,
      productPriceSale: (json['productPriceSale'] as num?)?.toDouble() ?? 0.0,
      productSalePercent: (json['productSalePercent'] ?? 0) as int,
      productSoldCount: (json['productSoldCount'] ?? 0) as int,
      productLocationSale: json['productLocationSale'] ?? '',
      categoryKey: json['categoryKey'] ?? '',
      imagesProduct: (json['imagesProduct'] as List<dynamic>? ?? [])
          .map((e) => ImageProduct.fromJson(e))
          .toList(),
    );
  }
}


class ImageProduct {
  final int id;
  final String imageUrl;
  final bool isPrimary;

  ImageProduct({
    required this.id,
    required this.imageUrl,
    required this.isPrimary,
  });

  factory ImageProduct.fromJson(Map<String, dynamic> json) {
    return ImageProduct(
      id: (json['id'] ?? 0) as int,
      imageUrl: json['imageUrl'] ?? '',
      isPrimary: json['isPrimary'] ?? false,
    );
  }
}
