import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import '../models/carrera.dart';

class CarreraService {
  // Método para obtener todas las carreras
  Future<List<Carrera>?> getCarreras() async {
    final url = Uri.parse('${BASE_URL}carrera/listar'); // Endpoint de carreras

    try {
      final response = await http.get(url);

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Aquí se espera que el backend retorne una lista de objetos carrera
        return List<Carrera>.from(data.map((x) =>
            Carrera.fromMap(x))); // Convierte el JSON a objetos de tipo Carrera
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
