import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/services/post_service.dart';
import 'package:tribu_app/models/post.dart';

class PostearController extends GetxController {
  final PostService postService = PostService();
  var usuarioId = 1.obs; // Usuario ID observable
  var posts = <Post>[].obs; // Lista observable de publicaciones
  var isLoading = false.obs; // Indicador de carga

  @override
  void onInit() {
    super.onInit();
    _loadUserId(); // Carga el ID del usuario logueado
    usuarioId.listen((_) {
      fetchPostsByUser(); // Carga los posts cada vez que cambia el usuarioId
    });
  }

  /// Cargar el ID del usuario desde SharedPreferences
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usuarioId.value = prefs.getInt('usuarioId') ?? 1; // Carga el ID guardado
  }

  /// Método para cargar los posts del usuario
  Future<void> fetchPostsByUser() async {
    isLoading.value = true;
    try {
      print(
          'Fetching posts for user: ${usuarioId.value}'); // Agrega un log para verificar el ID
      final fetchedPosts = await postService.fetchByUserId(usuarioId.value);
      posts.assignAll(fetchedPosts); // Asigna las publicaciones obtenidas
    } catch (e) {
      print('Error al obtener las publicaciones: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Eliminamos el método changeUser, ya que no es necesario y podría comprometer la seguridad
  // Future<void> changeUser(int newUserId) async {
  //   usuarioId.value = newUserId; // Actualiza el usuarioId
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('usuarioId', newUserId); // Guarda el nuevo ID
  // }
}
