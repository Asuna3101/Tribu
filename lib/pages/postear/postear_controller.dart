import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/models/post.dart';
import 'package:tribu_app/services/post_service.dart';

class PostearController extends GetxController {
  final PostService postService = PostService();
  var posts = <Post>[].obs; 
  var isLoading = false.obs; 
  int? userId; 

  @override
  void onInit() {
    super.onInit();
    _loadUserId();
  }

  _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('idUsuario'); 
    if (userId != null) {
      fetchPostsByUserId(userId!); 
    } else {
      print('ID de usuario no encontrado');
    }
  }

  // Función para obtener publicaciones por ID de usuario
  Future<void> fetchPostsByUserId(int userId) async {
    isLoading.value = true;
    try {
      posts.value = await postService.fetchByUserId(userId); // Llamamos al servicio
    } catch (e) {
      print('Error al obtener publicaciones: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
