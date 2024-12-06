import 'package:get/get.dart';
import 'package:tribu_app/models/post.dart';
import 'package:tribu_app/services/post_service.dart';

class MuroController extends GetxController {
  PostService postService = PostService();
  var posts = <Post>[].obs;
  /*var usuario = Usuario(idUsuario: 0, correo: '').obs;*/

  void listarPosts() async {
    posts.value = await postService.fetchAll();
    print(posts.value);
  }
}
