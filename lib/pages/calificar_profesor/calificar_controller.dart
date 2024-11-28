import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CalificarController extends GetxController {
  var profesor = Profesor(
    id: 1,
    nombre: "Valdivia Jose",
    calificaciones: [],
  ).obs;

  var estrellas = 0.obs;
  final TextEditingController reseniacontroller = TextEditingController();

  void seleccionarEstrellas(int valor) {
    estrellas.value = valor;
  }

  void enviarCalificacion() {
    if (estrellas.value == 0) {
      Get.snackbar(
        "Error",
        "Por favor selecciona una cantidad de estrellas.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (reseniacontroller.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Por favor escribe una reseña.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Agregar la nueva calificación al perfil del profesor
    profesor.value.calificaciones.add({
      'estrellas': estrellas.value,
      'reseña': reseniacontroller.text,
    });

    profesor.refresh(); // Actualiza el estado del profesor

    Get.snackbar(
      "¡Gracias!",
      "Tu calificación ha sido enviada.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Reiniciar el formulario
    estrellas.value = 0;
    reseniacontroller.clear();
  }

  @override
  void onClose() {
    reseniacontroller.dispose();
    super.onClose();
  }
}

class Profesor {
  int id;
  String nombre;
  List<Map<String, dynamic>> calificaciones;

  Profesor({
    required this.id,
    required this.nombre,
    required this.calificaciones,
  });
}
