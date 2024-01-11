import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import 'bottom_loader.dart';
import 'products_list_item.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsBloc>().add(ProductsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        switch (state.status) {
          case ProductsStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case ProductsStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.products.length
                    ? const BottomLoader()
                    : ProductsListItem(product: state.products[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.products.length
                  : state.products.length + 1,
              controller: _scrollController,
            );
          case ProductsStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
