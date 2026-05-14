  //controla si la app esta en modo oscuro o claro, y guarda esta preferencia en SharedPreferences
  // para que se mantenga incluso después de cerrar la aplicación. El estado del tema se puede cambiar 
  //llamando al método toggleTheme(), que invierte el valor actual del estado y lo guarda en SharedPreferences.
  
  import 'package:flutter_riverpod/legacy.dart';
  import 'package:shared_preferences/shared_preferences.dart';


  //funciona como un proveedor de estado para el tema de la aplicación, 
  //utilizando Riverpod para gestionar el estado y SharedPreferences para persistir
  // la preferencia del usuario entre sesiones. El proveedor se llama themeprovider y es un
  // StateNotifierProvider que expone un booleano que indica si el tema oscuro está activado o no. 
  //El ThemeNotifier es la clase que gestiona el estado del tema, cargando la preferencia al iniciar y 
  //permitiendo cambiarla con el método toggleTheme().  
  final themeprovider = StateNotifierProvider<ThemeNotifier, bool>((res) {
    return ThemeNotifier();
  });

  class ThemeNotifier extends StateNotifier<bool> {
    ThemeNotifier() : super(false) {
      _loadtheme();
    }

    void _loadtheme() async {
      //sirve para generar una instancia de SharedPreferences y acceder a los datos almacenados en ella,
      // como la preferencia de tema del usuario.
      //siempre que va a un gestor de datos demora, por eso es recomendable usar async y await
      //para esperar a que se cargue la información antes de continuar con el flujo del programa7

      //Obtener la instancia de SharedPreferences para acceder a los datos almacenados
      //si no hay un valor almacenado para 'isDark', se establece el estado en false (tema claro) por defecto
      final prefs = await SharedPreferences.getInstance();
      state =
          prefs.getBool('isDark') ??false; // Si no hay un valor almacenado, se establece el tema claro por defecto
      // Load the theme from shared preferences or any other storage
      // and update the state accordingly
    }

    void toggleTheme() async {
      // sirve para cambiar el estado del tema entre claro y oscuro. Cuando se llama a este método, se invierte el valor actual
      // del estado (si es true, se cambia a false, y viceversa) y luego se guarda la nueva preferencia en SharedPreferences 
      //para que se mantenga incluso después de cerrar la aplicación.
      // el metodo tiene que ser async porque va a acceder a un gestor de datos, en este caso SharedPreferences
      // y como es una operación que puede tomar tiempo, es recomendable usar async y await para esperar a que se complete antes de continuar con el
      //flujo del programa
      final pref = await SharedPreferences.getInstance();
      state = !state; // Cambia el estado actual al opuesto (claro a oscuro o viceversa) en el local storage
      await pref.setBool(
        'isDark',
        state,
      ); // Guarda el nuevo estado del tema en SharedPreferences para que se mantenga la preferencia del usuario incluso después de cerrar la aplicación
    }
  }
