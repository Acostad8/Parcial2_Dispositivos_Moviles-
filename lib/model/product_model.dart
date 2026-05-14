class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final List<String> images;
  final String category;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.images,
    required this.category,
  });

  // Convierte JSON → ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Convierte la lista dinámica a List<String>
    final imagesList = List<String>.from(json['images'] ?? []);

    return ProductModel(
      // ID del producto
      id: json['id'] ?? 0,
      // Título del producto
      title: json['title'] ?? 'sin título',
      // Convierte el precio a double
      price: (json['price'] as num?)?.toDouble() ?? 0,
      // Descripción
      description: json['description'] ?? 'sin descripción',
      // Primera imagen de la lista
      image: imagesList.isNotEmpty ? imagesList.first : '',
      // Lista completa de imágenes
      images: imagesList,
      // Nombre de la categoría
      category: json['category']?['name'] ?? 'sin categoría',
    );
  }
}
