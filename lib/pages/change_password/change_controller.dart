import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/services/usuario_service.dart';
import 'package:tribu_app/models/usuario.dart';

class ChangeController extends GetxController {
  TextEditingController txtNewPassword = TextEditingController();
  TextEditingController txtRepeatPassword = TextEditingController();
  var userCodigo = ''.obs;  // Código del usuario

  @override
  void onInit() {
    super.onInit();

    // Recuperamos el código del usuario desde los argumentos
    userCodigo.value = Get.arguments ?? '';  // Si no hay argumentos, se asigna vacío

    // Imprimir el código recibido para depuración
    print('Código recibido en ChangeController: ${userCodigo.value}');
  }

  void changePassword(BuildContext context) async {
    String newPassword = txtNewPassword.text;
    String repeatPassword = txtRepeatPassword.text;

    if (newPassword.isEmpty || repeatPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Todos los campos son obligatorios.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (newPassword != repeatPassword) {
      Get.snackbar(
        'Error',
        'Las contraseñas no coinciden.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Verificar que el código esté disponible antes de hacer la solicitud
    print('Código del usuario en changePassword: ${userCodigo.value}');  // Verifica que esté correcto

    bool success = await UsuarioService().changePassword(userCodigo.value, newPassword);

    if (success) {
      Get.snackbar(
        'Éxito',
        'Contraseña cambiada exitosamente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      txtNewPassword.clear();
      txtRepeatPassword.clear();
      Get.offAllNamed('/home');

    } else {
      Get.snackbar(
        'Error',
        'No se pudo cambiar la contraseña.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    txtNewPassword.dispose();
    txtRepeatPassword.dispose();
    super.onClose();
  }
}
