//CONFIGURACION DE LAS RUTAS DE LA APLICACION, PARA FACILITAR SU USO Y MANTENIMIENTO
//SE UTILIZA EN EL ARCHIVO router.dart PARA DEFINIR LAS RUTAS DE LA APLICACION


import 'package:prueba_parcial_2/config/router/router_model.dart';
import 'package:prueba_parcial_2/presentation/screen/Home/Home.dart';
import 'package:prueba_parcial_2/presentation/screen/Products/product_tab_screen.dart';
import 'package:prueba_parcial_2/presentation/screen/User/user_screen.dart';

List<RouterModel> routerConfig = [
  RouterModel(
    name: 'home',
    title: 'Home',
    description: 'This is the home page',
    path: '/home',
    widget: (context, state) => const Home(),
  ),
  RouterModel(
    name: 'user',
    title: 'User',
    description: 'This is the user page',
    path: '/user',
    widget: (context, state) => const UserScreen(),
  ),
  RouterModel(
    name: 'product',
    title: 'Product',
    description: 'This is the product page',
    path: '/product',
    widget: (context, state) => const ProductsTabScreen(),
  ),
];
