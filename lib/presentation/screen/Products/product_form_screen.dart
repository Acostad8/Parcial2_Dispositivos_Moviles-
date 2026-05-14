import 'package:flutter/material.dart';
import 'package:prueba_parcial_2/services/product_services.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});
  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  // Llave del formulario
  final _formKey = GlobalKey<FormState>();
  // Variables del modelo
  int id = 0;
  String title = '';
  double price = 0;
  String description = '';
  String image = '';
  int categoryId = 0;

  // Controller para imágenes
  final _imagesController = TextEditingController();

  // Lista de imágenes
  List<String> images = [];

  @override
  void dispose() {
    _imagesController.dispose();
    super.dispose();
  }

  void guardarFormulario() async {
    // Valida el formulario antes de guardar

    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Guarda los datos del formulario en las variables correspondientes
    _formKey.currentState!.save();
    

    final product = await ProductService.createProduct(
      title: title,
      price: price,
      description: description,
      categoryId: categoryId,
      imageUrl: image,
    );

    // Muestra un mensaje de éxito o error según el resultado de la creación del producto
    if (product != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto guardado correctamente')),
        
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TITLE
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  onSaved: (value) {
                    title = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El título es obligatorio';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // PRICE
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,

                  onSaved: (value) {
                    price = double.parse(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El precio es obligatorio';
                    }

                    final number = double.tryParse(value);

                    if (number == null) {
                      return 'Ingrese un número válido';
                    }

                    if (number < 0) {
                      return 'No se permiten números negativos';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),
                // DESCRIPTION
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  onSaved: (value) {
                    description = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La descripción es obligatoria';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                // IMAGE
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Imagen principal URL',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.image),
                  ),
                  onSaved: (value) {
                    image = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La imagen es obligatoria';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Category ID',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    categoryId = int.parse(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Seleccione una categoría';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: guardarFormulario,
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar Producto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
