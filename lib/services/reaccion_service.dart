import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import 'package:tribu_app/models/reacciones.dart';

class ReactionService {

  // Método para obtener las reacciones de un post específico
Future<Reaccion> fetchReacciones(int postId) async {

  final url = await http.get(Uri.parse('$BASE_URL/post/$postId/likes'));

  if (url.statusCode == 200) {
    return Reaccion.fromMap(json.decode(url.body));
  } else {
    throw Exception('Error al obtener reacciones');
  }
}

Future<String> toggleLike(int postId, int usuarioId) async {
    final url = Uri.parse('${BASE_URL}post/$postId/like');
    final Map<String, dynamic> data = {'usuario_id': usuarioId};

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        return 'Like agregado';
      } else if (response.statusCode == 200) {
        return 'Like removido';
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }




}