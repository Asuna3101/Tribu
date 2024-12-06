import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../services/alumno_service.dart';
import '../../models/usuario.dart';
import '../../services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  UsuarioService usuarioService = UsuarioService();
  AlumnoService alumnoService = AlumnoService();
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtContrasenia = TextEditingController();

  // Mensajes de error o éxitos
  RxString mensaje = ' '.obs;

  void login(BuildContext context) async {
    String codigo = txtUsuario.text;
    String contrasena = txtContrasenia.text;

    // Validar campos vacíos
    if (codigo.isEmpty || contrasena.isEmpty) {
      mensaje.value = 'Debe ingresar código de usuario y contraseña';
      Future.delayed(Duration(seconds: 4), () {
        mensaje.value = ' ';
      });
      return;
    }

    // Verificamos las credenciales del usuario
    Usuario? usuario = await usuarioService.login(codigo, contrasena);

    if (usuario != null) {
      mensaje.value = 'Success : Inicio exitoso. Bienvenido, ${usuario.nombre}';
      // Redirigir a la página de inicio con los detalles del usuario (sin necesidad de obtener un alumno)
      Navigator.pushNamed(context, '/home', arguments: usuario.toJson());

      // Guardar el idUsuario en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('codigo', usuario.codigo);
      await prefs.setString('correo', usuario.correo);
      await prefs.setString('nombre', usuario.nombre);
      await prefs.setString('celular', usuario.celular);
      await prefs.setString(
          'foto', usuario.foto); // Suponiendo que foto es un URL o path
      await prefs.setInt('carrera_id',
          usuario.carreraId); // carreraId es el campo del modelo Usuario
    } else {
      mensaje.value = 'Error : Usuario o contraseña incorrectos';
      Future.delayed(Duration(seconds: 4), () {
        mensaje.value = '';
      });
    }
  }
}
