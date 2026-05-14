//CONFIGURACION DE LAS RUTAS DE LA APLICACION, PARA FACILITAR SU USO Y MANTENIMIENTO

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:prueba_parcial_2/config/router/router_config.dart';
import 'package:prueba_parcial_2/presentation/auth/auth.dart';
import 'package:prueba_parcial_2/presentation/screen/Products/product_detail_screen.dart';
import 'package:prueba_parcial_2/presentation/shared/layout.dart';

// _STORAGE PARA GUARDAR EL TOKEN DE AUTENTICACION, SE UTILIZA EN EL REDIRECT DE LAS RUTAS PARA VER SI EL USUARIO ESTA LOGUEADO O NO
// SE UTILIZA EN EL ARCHIVO router.dart PARA DEFINIR LAS RUTAS DE LA APLICACION
//_STORAGE ES PRIVADO PARA QUE SOLO SE UTILICE EN ESTE ARCHIVO,
// Y NO SE PUEDA ACCEDER DESDE OTROS ARCHIVOS
//PARA PROTEGER VARIABLES INTERNAS
final _storage = FlutterSecureStorage();

//ESTANDAR UTILIZADO PARA TRANSMITIR INFORMACION ENTRE CLIENTE Y SERVIDOR, SE UTILIZA PARA GUARDAR EL TOKEN DE AUTENTICACION,

// SE USA PARA DEFINIR LAS RUTAS DE LA APLICACION, Y CONTROLAR EL ACCESO A ELLAS SEGUN SI EL USUARIO ESTA LOGUEADO O NO,
//REDIRECCIONANDOLO A LA PAGINA DE LOGIN SI NO LO ESTA, O A LA PAGINA DE PRODUCTOS SI LO ESTA
final GoRouter router = GoRouter(
  initialLocation: '/',

  redirect: (context, state) async {
    //EL TOKEN SE GUARDA EN EL STORAGE, Y SE VERIFICA SI EXISTE O NO PARA REDIRECCIONAR AL USUARIO A LA PAGINA DE LOGIN O A LA PAGINA DE PRODUCTOS

    //AL USUARIO HACER EL LOGIN, LA API DEVUELVE UN TOKEN, EL CUAL SE GUARDA EN EL STORAGE,
    // Y SE UTILIZA PARA VER SI EL USUARIO ESTA LOGUEADO O NO, Y REDIRECCIONARLO A LA PAGINA DE LOGIN O A LA PAGINA DE PRODUCTOS SEGUN CORRESPONDA
    final token = await _storage.read(key: 'token');

    //SE USA PARA VERIFICAR SI LA RUTA A LA QUE SE QUIERE ACCEDER ES PUBLICA O NO, EN ESTE CASO SOLO LA RUTA DE LOGIN ES PUBLICA,
    // LAS DEMAS SON PRIVADAS Y REQUIEREN DE UN TOKEN PARA ACC
    final isPublic = state.matchedLocation == '/';

    // SIN TOKEN redireccionar a login
    if (token == null && !isPublic) return '/';

    // CON TOKEN redireccionar a productos
    if (token != null && token.isNotEmpty && isPublic) return '/product';

    return null;
  },

  routes: [
    // LOGIN
    GoRoute(
      path: '/',
      name: 'Login',
      builder: (context, state) {
        return const Auth();
      },
    ),
    // TABS PRODUCTS
    GoRoute(
      path: '/product/:id',
      name: 'ProductDetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductDetailScreen(id: id);
      },
    ),

    // LAYOUT
    //CONTENEDOR DE RURAS QUE COMPARTEN UN MISMO LAYOUT, EN ESTE CASO EL LAYOUT ES EL MISMO PARA LAS RUTAS DE HOME, USER Y PRODUCT,
    // PERO SE PODRIA TENER OTRO LAYOUT PARA OTRAS RUTAS SI SE DESEA
    //ENVUELVE LAS RUTAS DE HOME, USER Y PRODUCT EN UN SHELLROUTE, PARA QUE COMPARTAN EL MISMO LAYOUT, Y ASI NO TENER QUE REPETIR EL LAYOUT EN CADA RUTA
    ShellRoute(
      builder: (context, state, child) {
        final title = state.topRoute?.name ?? 'App';
        return Layout(title: title, child: child);
      },
      routes: [
        ...routerConfig.map(
          (route) => GoRoute(
            path: route.path,
            name: route.name,
            builder: route.widget,
          ),
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) {
    return const Auth();
  },
);
