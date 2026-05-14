// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:prueba_parcial_2/helpers/interceptor.dart';

// class AuthService {

//   //crea una instancia de Dio con el interceptor de autenticación
//   //esto asegura que todas las solicitudes HTTP incluyan el token de autenticación

//   static final dio = Dio()..interceptors.add(AuthInterceptor());

//   // URL base de la API
//   static final url = 'https://api.escuelajs.co/api/v1';

//   // Almacena el token de autenticación de forma segura usando flutter_secure_storage
//   static const _storage = FlutterSecureStorage();

//   // Método para iniciar sesión y obtener el token de autenticación
//   // Recibe el email y la contraseña del usuario, realiza una solicitud POST a la API
//   // Si la respuesta es exitosa (status code 201), guarda el token en el almacenamiento seguro y devuelve null (indicando éxito)
//   // Si la respuesta no es exitosa, devuelve un mensaje de error
//   static Future<String?> getToken(String email, String password) async {
//     final Response response = await dio.post(
//       '$url/auth/login',
//       data: {
//         'email': email,
//         'password': password,
//       },
//     );

//     // Si la respuesta es exitosa (status code 201), guarda el token en el almacenamiento seguro y devuelve null (indicando éxito)
//     // Si la respuesta no es exitosa, devuelve un mensaje de error

//     if (response.statusCode == 201) {
//       final token = response.data['access_token'];
//       await _storage.write(key: 'token', value: token);

//       return null; // éxito
//     } else {
//       return response.data['message'] ?? 'Error al iniciar sesión';
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prueba_parcial_2/helpers/interceptor.dart';

class AuthService {
  // crea una instancia de Dio con el interceptor
  static final dio = Dio()..interceptors.add(AuthInterceptor());

  // URL base de la API
  static final url = 'https://api.escuelajs.co/api/v1';

  // almacenamiento seguro del token
  static const _storage = FlutterSecureStorage();

  // método login
  static Future<String?> getToken(String email, String password) async {
    try {
      final Response response = await dio.post(
        '$url/auth/login',
        data: {'email': email, 'password': password},
      );

      // login exitoso
      if (response.statusCode == 201) {
        final token = response.data['access_token'];

        // guardar token
        await _storage.write(key: 'token', value: token);

        return null;
      }

      return 'Error al iniciar sesión';
    } on DioException catch (e) {
      // error de la API
      if (e.response != null) {
        return e.response?.data['message'] ?? 'Credenciales inválidas';
      }

      // error de conexión
      return 'Error de conexión con el servidor';
    }
  }
}
