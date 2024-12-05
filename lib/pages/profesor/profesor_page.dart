import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/models/profesor.dart';
import 'package:tribu_app/configs/colors.dart';

class PerfilProfesorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recupera el objeto 'Profesor' pasado como argumento
    final Profesor profesor = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(profesor.nombre),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profesor.foto),
              backgroundColor: AppColors.primaryColor,
            ),
            SizedBox(height: 20),
            Text(
              profesor.nombre,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Correo: ${profesor.correo}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Biografía: ${profesor.biografia}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            profesor.asignaturas.isNotEmpty
                ? Text(
                    'Cursos: ${profesor.asignaturas.join(', ')}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  )
                : Text(
                    'No tiene cursos asignados.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
          ],
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
    );
  }
}
