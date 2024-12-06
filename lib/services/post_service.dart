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
}
