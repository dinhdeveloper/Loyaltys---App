import 'package:image_picker/image_picker.dart';

class CreateProductRequest {
  final String productName;
  final String categoryKey;
  final double price;
  final double? priceSale;
  final int salePercent;
  final int soldCount;
  final String? location;
  final int primaryIndex;
  final List<XFile> images;

  CreateProductRequest({
    required this.productName,
    required this.categoryKey,
    required this.price,
    this.priceSale,
    required this.salePercent,
    required this.soldCount,
    this.location,
    required this.primaryIndex,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'categoryKey': categoryKey,
      'price': price,
      'priceSale': priceSale,
      'salePercent': salePercent,
      'soldCount': soldCount,
      'location': location,
      'primaryIndex': primaryIndex,

      /// chỉ log thông tin ảnh, KHÔNG gửi file
      'images': images.map((e) => e.name).toList(),
    };
  }

  @override
  String toString() => toJson().toString();
}


