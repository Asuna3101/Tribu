import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/configs/colors.dart';
import 'calificar_controller.dart';

class CalificarProfesorPage extends StatelessWidget {
  final CalificarController controller = Get.put(CalificarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Calificar Profesor',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'Titulo',
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mostrar el nombre del profesor
                Center(
                  child: Obx(() => Text(
                        controller.profesorNombre.value, // Nombre del profesor
                        style: const TextStyle(
                          fontFamily: 'Titulo',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      )),
                ),
                const SizedBox(height: 30),
                const Text(
                  "¿Cuántas estrellas le asignas?",
                  style: TextStyle(
                    fontFamily: 'Texto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Obx(() => IconButton(
                          onPressed: () {
                            controller.seleccionarEstrellas(index + 1);
                          },
                          icon: Icon(
                            Icons.star,
                            color: index < controller.estrellas.value
                                ? AppColors.primaryColor
                                : Colors.grey,
                          ),
                        ));
                  }),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Deja una reseña:",
                  style: TextStyle(
                    fontFamily: 'Texto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.reseniacontroller,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Escribe aquí tu reseña",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.enviarCalificacion();
                      Navigator.of(context).pop(); // Regresa al perfil
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
            ),
          ),
        ),
      ),
    );
  }
}
