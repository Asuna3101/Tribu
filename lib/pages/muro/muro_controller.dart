import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/models/post.dart';
import 'package:tribu_app/services/post_service.dart';
import 'package:tribu_app/services/reaccion_service.dart';


class MuroController extends GetxController {
  PostService postService = PostService();
  ReactionService reactionService = ReactionService();
  var posts = <Post>[].obs;
  var usuarioId = 1.obs; // ID del usuario logueado, inicializado con un valor por defecto

  @override
  void onInit() {
    super.onInit();
    _loadUserId();
  }
  

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usuarioId.value = prefs.getInt('idUsuario') ?? 1; 
  }

  void listarPosts() async {
    posts.value = await postService.fetchAll();
  }

  Future<void> toggleLike(int postId) async {
    try {
      // Llamada al servicio para alternar el "Me gusta"
      String message = await reactionService.toggleLike(postId, usuarioId.value);
      print(message); // Muestra en la consola si fue un "Like agregado" o "Like removido"
    } catch (e) {
      print("Error al procesar la reacción: $e");
    }
  }

  
}