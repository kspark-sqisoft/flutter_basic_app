import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductsListItem extends StatelessWidget {
  const ProductsListItem({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${product.id}', style: textTheme.bodySmall),
        title: Text('${product.description}'),
        isThreeLine: true,
        subtitle: Text('${product.title}'),
        dense: true,
      ),
    );
  }
}
