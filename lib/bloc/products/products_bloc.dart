import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/product_datasource.dart';
import '../../data/models/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDataSource dataSource;
  ProductsBloc(
    this.dataSource,
  ) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await dataSource.getAllProduct();
      result.fold(
        (error) => emit(ProductsError(message: error)),
        (result) => emit(ProductsLoaded(data: result)),
      );
    });
  }
}
