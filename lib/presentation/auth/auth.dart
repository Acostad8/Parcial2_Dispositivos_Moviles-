import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_parcial_2/providers/theme_provider.dart';
import 'package:prueba_parcial_2/services/auth_Services.dart';
// import 'package:prueba_parcial_2/providers/language_provider.dart';

//Pantalla de autenticación que permite a los usuarios iniciar sesión en la aplicación.
//Contiene un formulario con campos para el nombre de usuario y la contraseña,
//y un botón para enviar las credenciales. También incluye opciones para cambiar el tema

//es consumerStatefulWidget, lo que permite acceder a los proveedores de estado
//para manejar el tema y el idioma de la aplicación.

//maneja el estado interno para controlar la carga durante el inicio de sesión y la visibilidad de la contraseña,
//y utiliza el servicio de autenticación para obtener el token de acceso al iniciar sesión correctamente.

class Auth extends ConsumerStatefulWidget {
  const Auth({super.key});
  @override
  //Crea el estado mutable para la pantalla de autenticación, permitiendo manejar la lógica de inicio de sesión,
  ConsumerState<Auth> createState() => _AuthState();
}

class _AuthState extends ConsumerState<Auth> {
  //Controladores para los campos de texto del formulario de inicio de sesión,
  //permiten acceder y manipular el texto ingresado por el usuario en los campos de usuario y contraseña.

  //Clave para el formulario, utilizada para validar los campos antes de enviar
  //las credenciales al servicio de autenticación.

  //sirve para validar el formulario, asegurándose de que los campos requeridos
  //estén completos antes de intentar iniciar sesión.
  final _formKey = GlobalKey<FormState>();

  //obtiene el texto
  final _userController = TextEditingController();

  //Controlador para el campo de contraseña, utilizado para acceder al texto
  //ingresado por el usuario en el campo de contraseña.
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _obscurePassword = true;

  void _login(BuildContext context) async {
    //valida campos del formulario
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa el formulario')),
      );
      return;
    }
    //si el formulario es válido, establece el estado de carga a true para
    //mostrar un indicador de progreso,
    setState(() => _loading = true);

    //mostrar un mensaje de error si las credenciales son incorrectas o si ocurre un error durante el proceso de inicio de sesión.
    //en los snackbar, se muestra un mensaje de éxito si el inicio de sesión es exitoso, o un mensaje de error si ocurre algún problema.
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);


    //llama al servicio de autenticación para obtener el token de acceso utilizando las credenciales ingresadas por el usuario.
    final error = await AuthService.getToken(
      _userController.text,
      _passwordController.text,
    );

    //verifica si el widget sigue montado antes de mostrar los mensajes y actualizar el estado,
    // evitando errores si el usuario navega fuera de la pantalla durante el proceso de inicio de sesión.
    if (!mounted) return;

    //si no hay error, muestra un mensaje de éxito y navega a la pantalla de productos.
    // Si hay un error, muestra el mensaje de error en un snackbar.
    if (error == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Logeado correctamente')),
      );
      setState(() => _loading = false);
      router.go('/product');
    } else {
      messenger.showSnackBar(SnackBar(content: Text(error)));
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = ref.watch(themeprovider);

    // final isEnglish = ref.watch(languageProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Parte superior
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: theme.colorScheme.primary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.text_snippet_rounded,
                        size: 52,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Parcial 2 - Flutter',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Inicia sesión para continuar',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Formulario
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _userController,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) => value == null || value.isEmpty
                            ? 'El usuario es requerido'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) => value == null || value.isEmpty
                            ? 'La contraseña es requerida'
                            : null,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton.icon(
                          onPressed: _loading ? null : () => _login(context),
                          icon: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.login),
                          label: Text(
                            _loading ? 'Ingresando...' : 'Iniciar sesión',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                isDark ? 'Modo Oscuro' : 'Modo Claro',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              IconButton.filled(
                                onPressed: () {
                                  ref
                                      .read(themeprovider.notifier)
                                      .toggleTheme();
                                },
                                icon: Icon(
                                  isDark ? Icons.dark_mode : Icons.light_mode,
                                ),
                              ),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Text(
                          //       isEnglish ? 'English' : 'Español',
                          //       style: const TextStyle(
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     const SizedBox(height: 10),
                          //     IconButton.filled(
                          //       onPressed: () {
                          //         ref
                          //             .read(languageProvider.notifier)
                          //             .toggleLanguage();
                          //       },
                          //       icon: const Icon(Icons.language),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
