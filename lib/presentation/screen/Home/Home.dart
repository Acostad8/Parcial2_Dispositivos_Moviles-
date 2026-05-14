import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_parcial_2/config/router/router_config.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...routerConfig.map((route) {
          return ListTile(
            title: Text(route.name),
            subtitle: Text(route.description),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.go(route.path),
          );
        }),
      ],
    );
  }
}
