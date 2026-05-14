
//sirve para interceptar las peticiones y respuestas de la API, y manejar los errores de manera centralizada.

//filtro que se ejecuta antes de cada petición, agregando el token de autenticación 
//a los encabezados de la solicitud. También maneja las respuestas y errores, 
//proporcionando mensajes de error personalizados según el tipo de error ocurrido.

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


//cuando dio hacer una peticion, se ejecuta el método onRequest, que lee el token de autenticación 
//almacenado de forma segura y lo agrega a los encabezados de la solicitud. 
//Luego, llama a handler.next(options) para continuar con la solicitud.

class AuthInterceptor extends Interceptor {
  static final _storage = FlutterSecureStorage();


  //Este método se ejecuta ANTES de enviar la petición.
  //modifica la peticon para agregar el token de autenticación en los encabezados.
  //luego, llama a handler.next(options) para continuar con la solicitud.

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //busca el token de autenticación almacenado de forma segura
    String token = await _storage.read(key: 'token') ?? '';
    
    //agrega el token a los encabezados de la solicitud
    options.headers['Authorization'] = 'Bearer $token';
    //credenciales de seguridad para la autenticación JWT (JSON Web Token)
    //la cual da el acceso a los recursos protegidos de la API. 
    
    //continúa con la solicitud, pasando las opciones modificadas al siguiente interceptor
    // o a la función de envío de la solicitud
    return handler.next(options);
  }

  @override
  //Este método se ejecuta DESPUÉS de recibir la respuesta de la API.
  //cuando el servidor responde a una solucitud correctamnete
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }



  @override
  //Este método se ejecuta cuando ocurre un error durante la solicitud o la respuesta

  //handler es un objeto que se utiliza para manejar el error, permitiendo pasar
  // el error al siguiente interceptor o a la función de manejo de errores.
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Error inesperado.';

    // Manejo de errores según el tipo de error ocurrido
    //Error de conexión debido a un tiempo de espera agotado.
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Error de conexión. Revisa tu conexión a internet.';

    
    } else if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode;
        print('>>> Error body: ${err.response?.data}');

      //petición incorrecta, lo que significa que el servidor no pudo entender la solicitud 
      //debido a una sintaxis inválida o datos faltantes.
      if (statusCode == 400) {
        errorMessage = 'Petición incorrecta.';

      //token inválido o expirado, lo que significa que el usuario no tiene autorización para acceder al recurso solicitado.
      } else if (statusCode == 401) {
        errorMessage = 'Usuario no autorizado';

      //servidor caido o con problemas, lo que impide que la API responda a las solicitudes.
      } else if (statusCode == 500) {
        errorMessage = 'Servicio no disponible';

      } else {
        errorMessage = 'Servicio no disponible';
      }
    } else if (err.response != null) {
      errorMessage = 'Error del servidor: ${err.response?.statusCode}';
    }

    // Solo una llamada a handler — sin el handler.next(err) previo
    
    //Envia el error personalizado al siguiente interceptor o a la función de manejo de errores, 
    //permitiendo que se maneje de manera centralizada en toda la aplicación.
    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: errorMessage,
      ),
    );
  }
}