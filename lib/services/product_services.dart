  import 'package:dio/dio.dart';
  import 'package:prueba_parcial_2/model/product_model.dart';
  import 'package:prueba_parcial_2/helpers/interceptor.dart';

  class ProductService {
    static final Dio dio = Dio()..interceptors.add(AuthInterceptor());
    
    // static final Dio dio = Dio();
    static const String url = 'https://api.escuelajs.co/api/v1';

    // Método para obtener una lista de productos desde la API
    // Recibe parámetros opcionales de offset y limit para paginación
    // Realiza una solicitud GET a la API y devuelve una lista de objetos ProductModel
    static Future<List<ProductModel>> getProducts({

      int offset = 0,
      int limit = 1000,
    }) async {
      try {
        // Realiza una solicitud GET a la API para obtener los productos con paginación
        final response = await dio.get(
          // ajusta la URL para incluir los parámetros de offset y limit
          '$url/products?offset=$offset&limit=$limit',
        );
        // Convierte la respuesta de la API en una lista de objetos ProductModel
        final data = response.data as List;

        // Mapea cada elemento de la lista de datos a un objeto ProductModel utilizando el método fromJson
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } on DioException catch (e) {
        throw Exception(
          e.response?.data.toString() ?? 'Error al cargar productos',
        );
      }
    }


    // Método para obtener un producto por su ID desde la API
    // Recibe el ID del producto como parámetro, realiza una solicitud GET a la API
    // Si la respuesta es exitosa (status code 200), devuelve un objeto ProductModel creado a partir de los datos de la respuesta
    // Si la respuesta no es exitosa o ocurre una excepción, devuelve null
    static Future<ProductModel?> getProductById(int id) async {
      try {
        // Realiza una solicitud GET a la API para obtener un producto específico por su ID
        final response = await dio.get('$url/products/$id');
        // Si la respuesta es exitosa (status code 200), devuelve un objeto ProductModel creado a partir de los datos de la respuesta
        if (response.statusCode == 200) {
          return ProductModel.fromJson(response.data);
        }
        return null;
      } on DioException {
        return null;
      }
    }

    // Método para crear un nuevo producto en la API
    // Recibe los detalles del producto como parámetros, realiza una solicitud POST a la API
    // Si la respuesta es exitosa, devuelve un objeto ProductModel creado a partir de los datos de la respuesta
    // Si ocurre una excepción, imprime el error y devuelve null
    static Future<ProductModel?> createProduct({
      required String title,
      required double price,
      required String description,
      required int categoryId,
      required String imageUrl,
    }) async {
      try {
        // Realiza una solicitud POST a la API para crear un nuevo producto con los detalles proporcionados
        // Ajusta la URL y el cuerpo de la solicitud según los requisitos de la API
        
        final response = await dio.post(
          '$url/products/',
          data: {
            'title': title,
            'price': price,
            'description': description,
            'categoryId': categoryId,
            'images': [imageUrl],
          },
        );
        print(response.data);
        return ProductModel.fromJson(response.data);
      } on DioException catch (e) {
        print(e.response?.data);
        return null;
      }
    }
  }
