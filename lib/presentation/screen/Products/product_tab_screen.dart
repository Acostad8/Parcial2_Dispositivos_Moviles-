import 'package:flutter/material.dart';
import 'package:prueba_parcial_2/presentation/screen/Products/product_form_screen.dart';
import 'package:prueba_parcial_2/presentation/screen/Products/product_screen.dart';

class ProductsTabScreen extends StatelessWidget {
  const ProductsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.add_box_outlined), text: 'Add Product'),
              Tab(icon: Icon(Icons.list_alt_outlined), text: 'Product'),
            ],
          ),
          const Expanded(
            child: TabBarView(children: [ProductFormScreen(), ProductScreen()]),
          ),
        ],
      ),
    );
  }
}
