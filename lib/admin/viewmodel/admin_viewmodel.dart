import 'package:dio/dio.dart';
import 'package:remindbless/admin/admin_models/create_product_request.dart';
import 'package:remindbless/admin/admin_usecase/admin_usecase.dart';
import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/data/models/category/category_model.dart';

class AdminViewModel  extends BaseViewModel{
  final AdminUseCase useCase;

  AdminViewModel(this.useCase) {
    fetchCategories();
  }

  List<Category> categories = [];

  Future<void> fetchCategories() async {
    try {
      categories = await useCase.fetchCategories();
    } catch (e) {
      categories = [];

    }
    notifyListeners();
  }

  List<Category> get categoriesWithoutFirst {
    if (categories.length <= 1) return [];
    return categories.skip(1).toList();
  }

  Future<void> createProduct(CreateProductRequest productRequest) async {
    try {
      await useCase.createProduct(productRequest);
      print("Create product success");
    } on DioException catch (e) {
      print("DIO ERROR: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("UNKNOWN ERROR: $e");
      rethrow;
    }
  }
}