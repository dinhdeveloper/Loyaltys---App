import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/usecases/products_usecase.dart';

class ProductViewmodel  extends BaseViewModel{
  final ProductsUseCase useCase;

  ProductViewmodel(this.useCase) {
    // Tự động fetch khi ViewModel được tạo
    //fetchCategories();
  }
}