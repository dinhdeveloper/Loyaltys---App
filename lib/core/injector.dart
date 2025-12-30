import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:remindbless/admin/admin_usecase/admin_usecase.dart';
import 'package:remindbless/admin/viewmodel/admin_viewmodel.dart';
import 'package:remindbless/data/server/api_service.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/services/network_service.dart';
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
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  // UseCase
  getIt.registerLazySingleton<CategoryUseCase>(() => CategoryUseCase(getIt<ApiService>()));
  getIt.registerLazySingleton<ProductsUseCase>(() => ProductsUseCase(getIt<ApiService>()));
  getIt.registerLazySingleton<AdminUseCase>(() => AdminUseCase(getIt<ApiService>()));

  // ViewModels
  getIt.registerFactory<HomeViewModel>(() => HomeViewModel(getIt<CategoryUseCase>()));
  getIt.registerFactory<CategoryViewModel>(() => CategoryViewModel(getIt<CategoryUseCase>()));
  getIt.registerFactory<ProductViewModel>(() => ProductViewModel(getIt<ProductsUseCase>()));
  getIt.registerFactory<AdminViewModel>(() => AdminViewModel(getIt<AdminUseCase>()));
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
        ChangeNotifierProvider(
          create: (_) => BackgroundController(),
        ),
        // Thêm các provider khác nếu cần
      ],
      child: child,
    );
  }
}