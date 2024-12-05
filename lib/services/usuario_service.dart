import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';
import '../configs/constants.dart';

class UsuarioService {
  // Método para login utilizando el backend
  Future<Usuario?> login(String codigo, String contrasena) async {
    final url = Uri.parse('${BASE_URL}login'); // Endpoint del login

    try {
      // Enviar solicitud POST con las credenciales
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'codigo': codigo,
          'contrasenia': contrasena, // Clave acorde al backend
        }),
      );

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extraer el objeto usuario del JSON
        final usuarioData = data['usuario'];

        // Crear y devolver una instancia de Usuario
        return Usuario.fromMap(usuarioData);
      } else {
        // Manejar error (credenciales incorrectas, etc.)
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      // Manejar errores de red u otros
      print('Error de conexión: $e');
      return null;
    }
  }


   // Método para registrar un nuevo usuario
  Future<bool> register(Usuario usuario) async {
    final url = Uri.parse('${BASE_URL}usuarios'); // Endpoint para registrar usuario

    try {
      // Enviar solicitud POST con los datos del usuario
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'codigo': usuario.codigo,
          'nombre': usuario.nombre,
          'correo': usuario.correo,
          'contrasenia': usuario.contrasena,
          'celular': usuario.celular,
          'foto': usuario.foto,
          'carrera_id': usuario.carreraId,
        }),
      );

      // Verificar si la respuesta es exitosa (creación de usuario)
      if (response.statusCode == 201) {
        // Usuario creado con éxito
        return true;
      } else {
        // Manejar error (usuario ya existe, etc.)
        print('Error: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      // Manejar errores de red u otros
      print('Error de conexión: $e');
      return false;
    }
  }

  // Método para obtener usuario por correo
  Future<Usuario?> getUserByEmail(String correo) async {
    final url = Uri.parse('${BASE_URL}usuario/correo/$correo'); // Endpoint para obtener usuario por correo

    try {
      // Enviar solicitud GET con el correo como parámetro
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Crear y devolver una instancia de Usuario
        return Usuario.fromMap(data);
      } else {
        // Manejar error (usuario no encontrado, etc.)
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      // Manejar errores de red u otros
      print('Error de conexión: $e');
      return null;
    }
  }
// Método para cambiar la contraseña en el backend
Future<bool> changePassword(String codigo, String nuevaContrasenia) async {
  final url = Uri.parse('${BASE_URL}usuarios/$codigo/contrasenia'); // Endpoint correcto para actualizar la contraseña

  // Verifica que el código y la nueva contraseña son correctos
  print('Código: $codigo, Nueva Contraseña: $nuevaContrasenia');  // Depuración

  try {
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nueva_contrasenia': nuevaContrasenia}),
    );

    if (response.statusCode == 200) {
      return true;  // Contraseña cambiada con éxito
    } else if (response.statusCode == 400) {
      // Error en la validación
      print('Error: La nueva contraseña no puede estar vacía');
      return false;
    } else if (response.statusCode == 404) {
      // Usuario no encontrado
      print('Error: Usuario no encontrado');
      return false;
    } else {
      // Error genérico
      print('Error: ${response.statusCode}, ${response.body}');
      return false;
    }
  } catch (e) {
    // Error de conexión
    print('Error de conexión: $e');
    return false;
  }
}


}


    /*if (usuario == 'admin' && contrasenia == '123') {
      return Usuario(idUsuario: 10, correo: '20210274@aloe.ulima.edu.pe');
    } else {
      return null;
    }*/
  