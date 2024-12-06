import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tribu_app/configs/constants.dart';
import 'package:tribu_app/models/post.dart';

class PostService {
  final url = Uri.parse(
      '${BASE_URL}posts/lista'); // Endpoint correcto para obtener los posts

  /// Fetch all posts from the backend
  Future<List<Post>> fetchAll() async {
    List<Post> posts = [];
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        posts = data
            .map((map) => Post.fromMap(map as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        print('No hay publicaciones registradas.');
      } else {
        print(
            'Error al cargar los posts: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error al conectar con el backend: $e');
    }
    return posts;
  }

  /// Fetch posts by user ID
  Future<List<Post>> fetchByUserId(int id) async {
    List<Post> posts = [];
    try {
      final url =
          Uri.parse('${BASE_URL}/posts/usuario/$id'); // Correct endpoint
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        posts = data
            .map((map) => Post.fromMap(map as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        print('No hay publicaciones registradas para el usuario con ID $id.');
      } else {
        print(
            'Error al cargar los posts del usuario: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error al conectar con el backend: $e');
    }
    return posts;
  }


  // Método para agregar un post (si aún no lo tienes en el servicio)
  Future<Map<String, dynamic>> agregarPost(int usuarioId, int carreraId, String descripcion, String enlace, {String? nombreMaterial, String? tipoMaterial}) async {
    final url = Uri.parse('${BASE_URL}posts-agregar'); // Endpoint para agregar el post

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'usuario_id': usuarioId,
          'carrera_id': carreraId,
          'descripcion': descripcion,
          'enlace': enlace,
          'nombre_material': nombreMaterial ?? 'Material sin nombre',
          'tipo_material': tipoMaterial ?? 'Otro',
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al agregar el post');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }
  

}