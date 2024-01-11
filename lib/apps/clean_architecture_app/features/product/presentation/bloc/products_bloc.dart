import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products.dart';
import 'products_event.dart';
import 'products_state.dart';

const _productsLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;
  ProductsBloc({required this.getProducts}) : super(const ProductsState()) {
    print('ProductsBloc constructor');
    on<ProductsFetched>(_onProductsFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  FutureOr<void> _onProductsFetched(
      ProductsFetched event, Emitter<ProductsState> emit) async {
    if (state.hasReachedMax) return null;
    if (state.status == ProductsStatus.initial) {
      final failureOrProducts = await getProducts(
          const GetProductsParams(skip: 0, limit: _productsLimit));
      emit(
        failureOrProducts.fold(
          (failure) => state.copyWith(
            status: ProductsStatus.failure,
          ),
          (products) => state.copyWith(
            status: ProductsStatus.success,
            products: products,
          ),
        ),
      );
    } else {
      final failureOrProducts = await getProducts(GetProductsParams(
          skip: state.products.length, limit: _productsLimit));

      emit(
        failureOrProducts.fold(
          (failure) => state.copyWith(
            status: ProductsStatus.failure,
          ),
          (products) => products.isEmpty
              ? state.copyWith(
                  hasReachedMax: true,
                )
              : state.copyWith(
                  status: ProductsStatus.success,
                  products: List.of(state.products)..addAll(products),
                  hasReachedMax: false,
                ),
        ),
      );
    }
    return null;
  }

  @override
  void onChange(Change<ProductsState> change) {
    print(change.nextState.products.length);
    super.onChange(change);
  }

  @override
  Future<void> close() {
    print('ProductsBloc close');
    return super.close();
  }
}
