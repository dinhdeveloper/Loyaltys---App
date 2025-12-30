import 'package:dio/dio.dart';
import 'package:remindbless/admin/admin_models/create_product_request.dart';
import 'package:remindbless/core/app_constants.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:http_parser/http_parser.dart';


class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl, connectTimeout: const Duration(seconds: 60), receiveTimeout: const Duration(seconds: 60)),
  );

  Future<List<Category>> getCategories() async {
    final response = await _dio.get(ApiConstants.categoriesEndpoint);

    if (response.statusCode == 200) {
      final body = response.data['body'] as List;
      return body.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<List<Product>> getProductsByCategoryKey(String categoryKey) async {
    final endpoint = '${ApiConstants.productsEndpoint}/category/$categoryKey';
    final response = await _dio.get(endpoint);

    if (response.statusCode == 200) {
      final body = response.data['body'] as List<dynamic>;
      return body.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<void> createProduct(CreateProductRequest request) async {
    final formData = FormData();

    /// text fields
    formData.fields.addAll([
      MapEntry('productName', request.productName),
      MapEntry('categoryKey', request.categoryKey),
      MapEntry('price', request.price.toString()),
      MapEntry('salePercent', request.salePercent.toString()),
      MapEntry('soldCount', request.soldCount.toString()),
      MapEntry('primaryIndex', request.primaryIndex.toString()),
    ]);

    if (request.priceSale != null) {
      formData.fields.add(
        MapEntry('priceSale', request.priceSale!.toString()),
      );
    }

    if (request.location != null) {
      formData.fields.add(
        MapEntry('location', request.location!),
      );
    }

    /// images
    for (final image in request.images) {
      formData.files.add(
        MapEntry(
          'images', // KHÔNG images[]
          await MultipartFile.fromFile(
            image.path,
            filename: image.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        ),
      );
    }

    await _dio.post(
      ApiConstants.addProductsEndpoint,
      data: formData,
    );
  }
}
