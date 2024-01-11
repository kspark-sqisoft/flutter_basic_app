import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products.dart';
import '../bloc/products_bloc.dart';

import '../../../../di/injection.dart' as di;
import '../bloc/products_event.dart';
import '../widgets/products_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('products')),
      body: BlocProvider(
        create: (context) =>
            ProductsBloc(getProducts: di.locator<GetProducts>())
              ..add(ProductsFetched()),
        child: const ProductsList(),
      ),
    );
  }
}
