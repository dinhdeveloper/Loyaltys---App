import 'package:remindbless/core/base_viewmodel.dart';
import 'package:remindbless/usecases/products_usecase.dart';

class ProductViewModel  extends BaseViewModel{
  final ProductsUseCase useCase;

  ProductViewModel(this.useCase) {
    // Tự động fetch khi ViewModel được tạo
    //fetchCategories();
  }
}