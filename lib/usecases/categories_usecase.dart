import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/data/server/api_service.dart';

class CategoryUseCase {
  final ApiService apiService;

  CategoryUseCase(this.apiService);

  Future<List<Category>> fetchCategories() {
    return apiService.getCategories();
  }
}