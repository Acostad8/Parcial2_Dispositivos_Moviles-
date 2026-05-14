import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prueba_parcial_2/config/router/router.dart';
import 'package:prueba_parcial_2/config/theme/app_theme.dart';

import 'package:prueba_parcial_2/providers/color_provider.dart';
import 'package:prueba_parcial_2/providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(colorChange);
    final isDark = ref.watch(themeprovider);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Widgets',
      theme: AppTheme(selectColor: color).themeData(isDark ? 1 : 0),
      routerConfig: router,
    );
  }
}
