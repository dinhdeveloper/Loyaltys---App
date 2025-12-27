import 'package:flutter/material.dart';
import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/data/models/products/product_model.dart';
import 'package:remindbless/usecases/categories_usecase.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryUseCase useCase;

  CategoryViewModel(this.useCase) {
    // Tự động fetch khi ViewModel được tạo
    fetchCategories();
  }

  List<Category> categories = [];
  List<Product> products = [];

  /// Fetch categories từ API
  Future<void> fetchCategories() async {
    try {
      categories = await useCase.fetchCategories();
    } catch (e) {
      categories = [];

    }
    notifyListeners();
  }

  Future<void> getProductsByCategoryKey(String categoryKey) async {
    try {
      products = await useCase.getProductsByCategoryKey(categoryKey);
      print("API result: ${products.length}");
    } catch (e) {
      products = [];
    }
    notifyListeners();
  }
}
