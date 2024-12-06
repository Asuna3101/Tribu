import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/configs/colors.dart';
import 'package:tribu_app/pages/postear/postear_controller.dart';
import 'package:tribu_app/models/post.dart';
import 'package:tribu_app/services/post_service.dart';

class PostearPage extends StatelessWidget {
  final PostearController controller = Get.put(PostearController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Postear",
          style: TextStyle(
            fontFamily: 'Titulo',
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  FutureBuilder<String?>(
                    future: _getUserPhoto(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          radius: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                          ),
                        );
                      }
                      final String? photoUrl = snapshot.data;
                      return CircleAvatar(
                        backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                            ? NetworkImage(photoUrl)
                            : AssetImage('assets/img/sample-profile-image.png') as ImageProvider,
                        radius: 25,
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showCreatePostDialog(context),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: '¿Qué quieres compartir hoy?',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon:
                              Icon(Icons.edit, color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildOptionButton('PPT', Icons.picture_as_pdf),
                    SizedBox(width: 10),
                    _buildOptionButton('PDF', Icons.picture_as_pdf),
                    SizedBox(width: 10),
                    _buildOptionButton('Excel', Icons.table_chart),
                    SizedBox(width: 10),
                    _buildOptionButton('Imagen', Icons.image),
                    SizedBox(width: 10),
                    _buildOptionButton('Actividad', Icons.event),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.posts.isEmpty) {
                    return Center(
                      child: Text(
                        'No hay publicaciones disponibles.',
                        style: TextStyle(
                          fontFamily: 'Texto',
                          fontSize: 16,
                          color: AppColors.primaryColor.withOpacity(0.7),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      final Post post = controller.posts[index];
                      return _buildPostCard(
                        name: post.nombreUsuario,
                        career: post.carrera,
                        text: post.descripcionPost,
                        image: post.enlaceMaterial,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
    );
  }

  Widget _buildPostCardDuplicate({
    required String name,
    required String career,
    required String text,
    required String image,
    required String foto,
    required SharedPreferences prefs,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FutureBuilder<String?>(
                  future: _getUserPhoto(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                        ),
                      );
                    }
                    final String? photoUrl = snapshot.data;
                    return CircleAvatar(
                      backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                          ? NetworkImage(photoUrl)
                          : AssetImage('assets/img/sample-profile-image.png') as ImageProvider,
                      radius: 20,
                    );
                  },
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Texto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      career,
                      style: TextStyle(
                        fontFamily: 'Texto',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Texto',
              ),
            ),
            SizedBox(height: 10),
            image.isNotEmpty
                ? Image.network(image)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? usuarioId = prefs.getInt('idUsuario');
    final int? carreraId = prefs.getInt('carrera_id');
    final String? nombre = prefs.getString('nombre');
    final String? foto = prefs.getString('foto');

    if (usuarioId == null || carreraId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pueden recuperar los datos del usuario')),
      );
      return;
    }

    final TextEditingController descripcionController = TextEditingController();
    final TextEditingController enlaceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear nueva publicación'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descripcionController,
                  decoration: InputDecoration(
                    hintText: 'Descripción de la publicación',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: enlaceController,
                  decoration: InputDecoration(
                    hintText: 'Enlace del material',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String descripcion = descripcionController.text.trim();
                final String enlace = enlaceController.text.trim();

                if (descripcion.isEmpty || enlace.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, completa todos los campos')),
                  );
                  return;
                }

                try {
                  PostService postService = PostService();
                  await postService.agregarPost(
                    usuarioId, 
                    carreraId, 
                    descripcion, 
                    enlace
                  );

                  controller.fetchPostsByUserId(usuarioId);

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Publicación creada exitosamente')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al crear la publicación: $e')),
                  );
                }
              },
              child: Text('Publicar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOptionButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: AppColors.primaryColor),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Texto',
          color: AppColors.primaryColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPostCard({
    required String name,
    required String career,
    required String text,
    required String image,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FutureBuilder<String?>(
                  future: _getUserPhoto(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                        ),
                      );
                    }
                    final String? photoUrl = snapshot.data;
                    return CircleAvatar(
                      backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                          ? NetworkImage(photoUrl)
                          : AssetImage('assets/img/sample-profile-image.png') as ImageProvider,
                      radius: 20,
                    );
                  },
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Texto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      career,
                      style: TextStyle(
                        fontFamily: 'Texto',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Texto',
              ),
            ),
            SizedBox(height: 10),
            image.isNotEmpty
                ? Image.network(image)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Future<String?> _getUserPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('foto');
  }
}
