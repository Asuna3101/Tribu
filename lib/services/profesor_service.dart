import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import '../models/profesor.dart';

class ProfesorService {
  // Método para obtener todos los Profesores en una lista
  Future<List<Profesor>?> getProfesor() async {
    final url =
        Uri.parse('${BASE_URL}profesores/lista'); // Endpoint de Profesors

    try {
      final response = await http.get(url);

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Aquí se espera que el backend retorne una lista de objetos Profesor
        return List<Profesor>.from(data.map((x) => Profesor.fromMap(
            x))); // Convierte el JSON a objetos de tipo Profesor
      } else {
        // Si la respuesta no es exitosa
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      // Manejar errores de conexión o de otro tipo
      print('Error de conexión: $e');
      return null;
    }
  }

  // Método para obtener un Profesor por su id
  Future<Profesor?> getProfesorById(int id) async {
    final url = Uri.parse('${BASE_URL}profesores/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Profesor.fromMap(data);
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }

// Método para obtener un Profesor por su nombre
  Future<List<dynamic>?> getProfesorByName(String nombre) async {
    final url = Uri.parse('${BASE_URL}profesores/buscar?nombre=$nombre');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }

// Método para obtener un Profesor por su curso
  Future<List<dynamic>?> getProfesorByCurso(String curso_profesor) async {
    final url = Uri.parse('${BASE_URL}profesores/buscar?curso=$curso_profesor');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}
