import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/services/calificacion_service.dart';

class CalificarController extends GetxController {
  final CalificacionService calificacionService = CalificacionService();

  // ID y nombre del profesor
  final profesorId = 0.obs;
  final profesorNombre = ''.obs;

  // Estrellas seleccionadas
  final estrellas = 0.obs;

  // ID del usuario logueado
  final usuarioId = 0.obs;

  // Controlador para la reseña
  final reseniacontroller = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
      


    // Recuperar el ID del usuario desde SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usuarioId.value = prefs.getInt('idUsuario') ?? 0;

    // Verificar si el usuario está logueado
    if (usuarioId.value == 0) {
      Get.snackbar(
        'Error',
        'Debes iniciar sesión para calificar.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/login'); // Redirigir a la pantalla de login
      return;
    }

    // Recibir ID y nombre del profesor desde Get.arguments
    final arguments = Get.arguments as Map<String, dynamic>;
    profesorId.value = arguments['idProfesor'] as int;
    profesorNombre.value = arguments['nombreProfesor'] as String;
  }

  // Seleccionar estrellas
  void seleccionarEstrellas(int numero) {
    estrellas.value = numero;
  }

  // Enviar calificación
  Future<void> enviarCalificacion() async {
    if (estrellas.value == 0 || reseniacontroller.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Debes completar todos los campos antes de calificar.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await calificacionService.enviarCalificacion(
        idProfesor: profesorId.value,
        usuarioId: usuarioId.value, // Usar el ID del usuario logueado
        estrella: estrellas.value,
        resenia: reseniacontroller.text,
      );
      Get.snackbar(
        'Éxito',
        'La calificación se ha enviado correctamente.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Ocurrió un problema al enviar la calificación.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
