import 'package:flutter/material.dart';
import 'package:remindbless/data/models/category/category_model.dart';
import 'package:remindbless/usecases/categories_usecase.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryUseCase useCase;

  CategoryViewModel(this.useCase) {
    fetchCategories();
  }

  bool isLoading = false;
  List<Category> categories = [];
  String? error;

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      categories = await useCase.fetchCategories();
      error = null;
    } catch (e) {
      error = e.toString();
      categories = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
