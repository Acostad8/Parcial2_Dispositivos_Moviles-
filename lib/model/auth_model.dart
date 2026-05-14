// Un model es una clase que representa la estructura de datos de una entidad.

//MANEJA LOS DATOS DE AUTENTICACIÓN, COMO LOS TOKENS DE ACCESO Y REFRESCO, 
//Y PROPORCIONA MÉTODOS PARA CREAR INSTANCIAS A PARTIR DE RESPUESTAS JSON.

class AuthModel {
  String accessToken; //TOKEN DE ACCESO PARA ACCEDER A LOS RECURSOS PROTEGIDOS DE LA API.
  String refreshToken; //TOKEN DE REFRESCO PARA OBTENER UN NUEVO TOKEN DE ACCESO CUANDO EL ACTUAL EXPIRE.


  //CONSTRUCTOR DE LA CLASE, REQUIERE LOS TOKENS DE ACCESO Y REFRESCO PARA CREAR UNA INSTANCIA DE AuthModel.
  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  //MÉTODO DE FÁBRICA PARA CREAR UNA INSTANCIA DE AuthModel A PARTIR DE UN MAPA JSON,
  //LO QUE PERMITE CONVERTIR LA RESPUESTA DE LA API EN UN
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  } 
}
