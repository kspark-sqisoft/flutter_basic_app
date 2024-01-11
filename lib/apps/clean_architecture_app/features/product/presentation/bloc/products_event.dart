import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductsFetched extends ProductsEvent {}
