import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_parcial_2/model/product_model.dart';
import 'package:prueba_parcial_2/services/product_services.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: ProductService.getProducts(),

        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // ERROR
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // EMPTY
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos'));
          }
          
          final products = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  // AVATAR
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: product.image.isNotEmpty
                        ? NetworkImage(product.image)
                        : null,
                    child: product.image.isEmpty
                        ? const Icon(Icons.image_not_supported)
                        : null,
                  ),
                  // NOMBRE
                  title: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // DESCRIPCIÓN
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // PRECIO
                  trailing: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // CLICK
                  //agrega la pantalla encima de la actual con el pusgh, y el go reemplaza la pantalla actual por la nueva
                  //refirige a la pantalla de detalle del producto, pasando el id del producto como parámetro
                  //para que el detalle pueda cargar la información del producto específico
                  onTap: () {
                    context.push('/product/${product.id}');
                    // Navegar al detalle
                    // context.go('/products/${product.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
