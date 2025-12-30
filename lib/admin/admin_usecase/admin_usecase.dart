import 'package:remindbless/admin/admin_models/create_product_request.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/data/server/api_service.dart';

class AdminUseCase {
  final ApiService apiService;

  AdminUseCase(this.apiService);

  Future<List<Category>> fetchCategories() {
    return apiService.getCategories();
  }

  Future<List<Product>> getProductsByCategoryKey(String categoryKey) {
    return apiService.getProductsByCategoryKey(categoryKey);
  }

  Future<void> createProduct(CreateProductRequest createProduct) {
    return apiService.createProduct(createProduct);
  }
}