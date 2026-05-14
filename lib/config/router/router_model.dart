//MODELO DE LAS RUTAS DE LA APLICACION, PARA FACILITAR SU USO Y MANTENIMIENTO
//SE UTILIZA EN EL ARCHIVO router.dart PARA DEFINIR LAS RUTAS DE LA APLICACION
//SE UTILIZA EN EL ARCHIVO main.dart PARA DEFINIR LAS RUTAS DE LA APLICACION
//SE UTILIZA EN EL ARCHIVO home.dart PARA DEFINIR LAS RUTAS DE LA APLICACION

import 'package:go_router/go_router.dart';

class RouterModel{
  String name;
  String title;
  String description;
  String path;
  GoRouterWidgetBuilder widget;

  RouterModel({
    required this.name,
    required this.title,
    required this.description,
    required this.path,
    required this.widget,
  });

}