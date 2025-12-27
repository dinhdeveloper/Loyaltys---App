import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/usecases/categories_usecase.dart';

import '../data/models/products/product_model.dart' show Product;

class HomeViewModel extends BaseViewModel {
  final CategoryUseCase useCase;

  HomeViewModel(this.useCase);

  List<Category> categories = [];
  List<Product> products = [];

  /// Optional: lấy argument khi screen init
  @override
  void initBaseData() {
    super.initBaseData();
    fetchCategories();
  }

  /// Fetch categories từ API
  Future<void> fetchCategories() async {
    try {
      categories = await useCase.fetchCategories();
    } catch (e) {
      categories = [];
    }
    notifyListeners();
  }
}
