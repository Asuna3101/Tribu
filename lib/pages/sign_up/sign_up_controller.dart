import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/models/carrera.dart';
import 'package:tribu_app/services/carrera_service.dart';
import 'package:tribu_app/models/usuario.dart';
import 'package:tribu_app/services/usuario_service.dart';


class SignUpController extends GetxController {
  TextEditingController txtCodigo = TextEditingController();
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtCorreo = TextEditingController();
  TextEditingController txtCelular = TextEditingController();
  TextEditingController txtContrasenia = TextEditingController();
  RxString selectedCarrera = ''.obs; // Usa `.obs` para hacerlo reactivo
  String selectedFoto = ''; // Foto opcional

  // Método para obtener las carreras desde el backend
  Future<List<Carrera>> obtenerCarreras() async {
    // Llama al servicio para obtener las carreras
    List<Carrera>? carreras = await CarreraService().getCarreras();
    return carreras ?? [];
  }

  // Método para crear una cuenta de usuario
  Future<void> createAccount(BuildContext context) async {
    String codigo = txtCodigo.text;
    String nombre = txtNombre.text;
    String correo = txtCorreo.text;
    String celular = txtCelular.text;
    String contrasenia = txtContrasenia.text;

    // Verificar que todos los campos sean llenados correctamente
    if (codigo.isEmpty || nombre.isEmpty || correo.isEmpty || celular.isEmpty || contrasenia.isEmpty || selectedCarrera.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor completa todos los campos')));
      return;
    }

    // Crear el nuevo usuario sin el idUsuario
    Usuario nuevoUsuario = Usuario(
      idUsuario: 0,  // Al registrar no se incluye el idUsuario, se generará en la base de datos
      codigo: codigo,
      correo: correo,
      nombre: nombre,
      celular: celular,
      foto: selectedFoto, // Foto opcional
      contrasena: contrasenia,
      carreraId: int.parse(selectedCarrera.value),  // Usar `.value` para obtener el valor de `RxString`
    );

    // Usar el servicio de usuario para registrar al nuevo usuario
    bool result = await UsuarioService().register(nuevoUsuario);

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cuenta creada exitosamente')));
      Navigator.of(context).pushNamed('/sign-in'); // Redirigir al login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al crear la cuenta')));
    }
  }
}