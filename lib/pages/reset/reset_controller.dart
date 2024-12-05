import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/pages/change_password/change_password_page.dart';
import 'package:tribu_app/services/usuario_service.dart';
import 'package:tribu_app/models/usuario.dart';

class ResetController extends GetxController {
  TextEditingController txtCorreo = TextEditingController();
  var userFound = Rx<Usuario?>(null);

  void resetPassword(BuildContext context) async {
    String correo = txtCorreo.text;
    if (correo.isEmpty) {
      Get.snackbar(
        'Error',
        'El correo es obligatorio.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    var usuarioService = UsuarioService();
    Usuario? user = await usuarioService.getUserByEmail(correo);

    if (user != null) {
      userFound.value = user; // Almacena el usuario encontrado
      Get.snackbar(
        'Éxito',
        'Usuario encontrado: ${user.nombre}.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      userFound.value = null; // Resetea el usuario encontrado
      Get.snackbar(
        'Error',
        'Usuario no encontrado.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void goToChangePassword() {
    if (userFound.value != null) {
      Get.to(() => ChangePasswordPage(), arguments: userFound.value!.codigo);
    } else {
      Get.snackbar(
        'Error',
        'Primero busca un usuario.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    txtCorreo.dispose();
    super.onClose();
  }
}
