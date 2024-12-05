import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/configs/colors.dart';
import 'buscar_profesores_controller.dart';
import 'package:tribu_app/models/profesor.dart';

class BuscarProfesoresPage extends StatelessWidget {
  final BuscarProfesoresController controller =
      Get.put(BuscarProfesoresController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.buscarProfesorPorNombre(value),
                decoration: InputDecoration(
                  hintText: 'Buscar profesor',
                  prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.profesores.isEmpty) {
                    return Center(
                      child: Text(
                        'No se encontraron profesores.',
                        style: TextStyle(
                          fontFamily: 'Texto',
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.profesores.length,
                    itemBuilder: (context, index) {
                      final Profesor profesor = controller.profesores[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profesor.foto),
                          backgroundColor: AppColors.primaryColor,
                        ),
                        title: Text(
                          profesor.nombre,
                          style: TextStyle(
                            fontFamily: 'Texto',
                            fontSize: 16,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        subtitle: Text(
                          profesor.asignatura,
                          style: TextStyle(
                            fontFamily: 'Texto',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          Get.toNamed('/perfilProfesor',
                              arguments: profesor); // Navega al perfil
                        },
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
}
