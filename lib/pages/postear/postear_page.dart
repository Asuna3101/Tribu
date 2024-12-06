import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/configs/colors.dart';
import 'package:tribu_app/pages/postear/postear_controller.dart';
import 'package:tribu_app/models/post.dart';

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
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/img/sample-profile-image.png'),
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
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

  Widget _buildPostCard({
    required String name,
    required String career,
    required String text,
    required String image,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Titulo',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              career,
              style: TextStyle(
                fontFamily: 'Texto',
                fontSize: 14,
                color: AppColors.primaryColor.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Texto',
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // Acción para cada opción de archivo
      },
      icon: Icon(icon, color: AppColors.secondaryColor),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Texto',
          fontSize: 14,
          color: AppColors.secondaryColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
      ),
    );
  }
}
