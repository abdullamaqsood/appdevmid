import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService _apiService;

  ProductBloc({required ApiService apiService})
      : _apiService = apiService,
        super(InitialProductState()) {
    on<LoadProducts>(_handleFetchProducts);
  }

  Future<void> _handleFetchProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(LoadingProductState());
    try {
      final productList = await _apiService.fetchProducts();
      emit(LoadedProductState(productList: productList));
    } catch (error) {
      emit(ErrorProductState(errorMessage: error.toString()));
    }
  }
}
