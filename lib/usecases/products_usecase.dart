import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/data/server/api_service.dart';

class ProductsUseCase {
  final ApiService apiService;

  ProductsUseCase(this.apiService);

  Future<List<Product>> getProductsByCategoryKey(String categoryKey) {
    return apiService.getProductsByCategoryKey(categoryKey);
  }
}