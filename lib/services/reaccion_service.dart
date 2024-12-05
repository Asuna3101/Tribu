import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import 'package:tribu_app/models/reacciones.dart';
class ReaccionService {

  // Método para obtener las reacciones de un post específico
Future<Reaccion> fetchReacciones(int postId) async {

  final url = await http.get(Uri.parse('$BASE_URL/post/$postId/likes'));

  if (url.statusCode == 200) {
    return Reaccion.fromMap(json.decode(url.body));
  } else {
    throw Exception('Error al obtener reacciones');
  }
}

}