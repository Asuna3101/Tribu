import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar GetX
import 'package:tribu_app/pages/inicio/inicio_page.dart';
import 'package:tribu_app/pages/home/home_page.dart';
import 'package:tribu_app/pages/sign_in/sign_in_page.dart';
import 'package:tribu_app/pages/sign_up/sign_up_page.dart';
import 'package:tribu_app/pages/reset/reset_page.dart';
import 'package:tribu_app/pages/perfil/perfil_page.dart';
import 'package:tribu_app/pages/cursos/cursos_page.dart';
import 'package:tribu_app/pages/editar/editar_page.dart';
import 'package:tribu_app/pages/postear/postear_page.dart';
import 'package:tribu_app/pages/config/config_page.dart';
import 'package:tribu_app/pages/change_password/change_password_page.dart';
import 'package:tribu_app/configs/app_theme.dart'; // Importa tu archivo de temas
import 'package:tribu_app/pages/visualizacion/visualizacion_page.dart';
import 'package:tribu_app/pages/profesor/profesor_page.dart';
import 'package:tribu_app/pages/calificar_profesor/calificar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Usar GetMaterialApp en lugar de MaterialApp
      title: 'Tribu',
      theme: AppTheme.lightTheme(), // Usa el tema claro desde AppTheme
      darkTheme: AppTheme.darkTheme(), // Usa el tema oscuro desde AppTheme
      themeMode: ThemeMode.system, // Cambia automáticamente según el sistema
      initialRoute: '/inicio',
      getPages: [
        // Usa getPages en lugar de routes
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/sign-in', page: () => SignInPage()),
        GetPage(name: '/sign-up', page: () => SignUpPage()),
        GetPage(name: '/reset', page: () => ResetPage()),
        GetPage(name: '/inicio', page: () => InicioPage()),
        GetPage(name: '/perfil', page: () => PerfilPage()),
        GetPage(name: '/cursos', page: () => CursosPage()),
        GetPage(name: '/editar', page: () => EditarPage()),
        GetPage(name: '/postear', page: () => PostearPage()),
        GetPage(name: '/config', page: () => ConfigPage()),
        GetPage(name: '/change', page: () => ChangePasswordPage()),
        GetPage(name: '/visualizacion', page: () => VisualizacionPage()),
        GetPage(name: '/profesor', page: () => PerfilProfesorPage()),
        GetPage(name: '/calificar', page: () => CalificarProfesorPage()),
      ],
    );
  }
}
