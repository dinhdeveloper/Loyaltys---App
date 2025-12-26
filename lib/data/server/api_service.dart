import 'package:dio/dio.dart';
import 'package:remindbless/core/app_constants.dart';
import 'package:remindbless/data/models/category/category_model.dart';


class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<List<Category>> getCategories() async {
    final response = await _dio.get(ApiConstants.categoriesEndpoint);

    if (response.statusCode == 200) {
      final body = response.data['body'] as List;
      return body.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}