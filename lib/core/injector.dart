import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remindbless/data/server/api_service.dart';
import 'package:remindbless/usecases/categories_usecase.dart';
import 'package:remindbless/usecases/products_usecase.dart';
import 'package:remindbless/viewmodel/category_viewmodel.dart';


import 'package:get_it/get_it.dart';
import 'package:remindbless/viewmodel/home_viewmodel.dart';
import 'package:remindbless/viewmodel/product_viewmodel.dart';

final getIt = GetIt.instance;

/// Đăng ký các singleton, factory
void setupLocator() {
  // Service / Repository
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // UseCase
  getIt.registerLazySingleton<CategoryUseCase>(() => CategoryUseCase(getIt<ApiService>()));
  getIt.registerLazySingleton<ProductsUseCase>(() => ProductsUseCase(getIt<ApiService>()));

  // ViewModels
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel(getIt<CategoryUseCase>()));
  getIt.registerFactory<CategoryViewModel>(() => CategoryViewModel(getIt<CategoryUseCase>()));
  getIt.registerFactory<ProductViewmodel>(() => ProductViewmodel(getIt<ProductsUseCase>()));
}

/// MultiProvider dùng để wrap toàn bộ app
class Injector {
  static Widget wrapWithProviders({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => getIt<HomeViewModel>(),
        ),
        ChangeNotifierProvider<CategoryViewModel>(
          create: (_) => getIt<CategoryViewModel>(),
        ),
        // Thêm các provider khác nếu cần
      ],
      child: child,
    );
  }
}