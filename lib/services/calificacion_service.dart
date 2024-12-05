import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import 'package:tribu_app/models/calificacion.dart';

class CalificacionService {
// Método para obtener un Profesor por su id
  Future<List<Calificacion>?> getCalificacionByProfesorId(
      int idProfesor) async {
    final url = Uri.parse('${BASE_URL}profesores/$idProfesor/calificaciones');
    try {
      final response = await http.get(url);

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['calificaciones'];
        print('Datos recibidos: $data');

        // Aquí se espera que el backend retorne una lista de objetos Calificacion
        return List<Calificacion>.from(data.map((x) => Calificacion.fromMap(
            x))); // Convierte el JSON a objetos de tipo Calificacion
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
}
