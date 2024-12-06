import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import 'package:tribu_app/models/comentarios.dart';

class ComentarioService {

  // Método para obtener los comentarios de un post por su ID
  Future<List<Comentario>?> getComentariosByPostId(int postId) async {
    final url = Uri.parse('${BASE_URL}posts/comentarios/$postId'); // Endpoint para obtener los comentarios

    try {
      final response = await http.get(url);

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Aquí se espera que el backend retorne una lista de objetos comentario
        return List<Comentario>.from(data.map((x) => Comentario.fromMap(x))); // Convierte el JSON a objetos de tipo Comentario
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

   Future<Map<String, dynamic>?> agregarComentario(int postId, int usuarioId, String texto) async {
    final url = Uri.parse('${BASE_URL}post/$postId/comment'); // Endpoint de comentarios

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'usuario_id': usuarioId,
          'texto': texto,
        }),
      );

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data; // Retorna la respuesta completa del servidor
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
