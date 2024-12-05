/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/configs/colors.dart';
import 'profesor_controller.dart';

class ProfesorPage extends StatelessWidget {
  final ProfesorController control = Get.put(ProfesorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: Text(
            'Tribu',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'Titulo',
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColors.primaryColor),
            onPressed: () {
              // Acción de notificaciones
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: AppColors.primaryColor),
            onPressed: () {
              Navigator.of(context).pushNamed('/perfil');
            },
          ),
        ],
      ),
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (control.profesor.value == null) {
                  return CircularProgressIndicator();
                } else {
                  final profesor = control.profesor.value!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          profesor.nombre,
                          style: const TextStyle(
                            fontFamily: 'Titulo',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoBox('Curso', profesor.curso),
                      _buildInfoBox('Correo', profesor.correo),
                      const SizedBox(height: 10),
                      Text(
                        profesor.biografia,
                        style: const TextStyle(
                          fontFamily: 'Texto',
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(
                        thickness: 1,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Calificaciones Individuales',
                        style: const TextStyle(
                          fontFamily: 'Titulo',
                          fontSize: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Renderiza cada calificación individual
                      ...profesor.calificaciones.map((calificacion) {
                        return _buildCalificacionItem(calificacion);
                      }).toList(),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Redirige a la vista del formulario de calificación
                            Navigator.of(context).pushNamed('/calificar');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Calificar',
                            style: TextStyle(
                              fontFamily: 'Titulo',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir un cuadro de información
  Widget _buildInfoBox(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Texto',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          Flexible(
            child: Text(
              content,
              style: const TextStyle(
                fontFamily: 'Texto',
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir un ítem de calificación individual
  Widget _buildCalificacionItem(double calificacion) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: AppColors.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            calificacion.toStringAsFixed(1),
            style: const TextStyle(
              fontFamily: 'Texto',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
*/