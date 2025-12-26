import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remindbless/data/server/api_service.dart';
import 'package:remindbless/usecases/categories_usecase.dart';
import 'package:remindbless/viewmodel/category_viewmodel.dart';


class Injector {
  static List<SingleChildWidget> providers() {
    // Khởi tạo các dependency
    final apiService = ApiService();
    final categoryUseCase = CategoryUseCase(apiService);

    return [
      ChangeNotifierProvider(
        create: (_) => CategoryViewModel(categoryUseCase),
      ),
    ];
  }

  static Widget wrapWithProviders({required Widget child}) {
    return MultiProvider(
      providers: providers(),
      child: child,
    );
  }
}
