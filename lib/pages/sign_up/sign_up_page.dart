import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/configs/colors.dart';
import '../../models/carrera.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController control = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/img/adaptive_icon_foreground.png',
                  height: 120.0,
                ),
                SizedBox(height: 15),
                // Título
                Text(
                  'Crear una cuenta',
                  style: TextStyle(
                    fontFamily: 'Titulo',
                    fontSize: 22,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                // Campos de entrada (Código, Nombre, Correo, etc.)
                _buildTextField(control.txtCodigo, 'CODIGO'),
                SizedBox(height: 15),
                _buildTextField(control.txtNombre, 'NOMBRE'),
                SizedBox(height: 15),
                _buildTextField(control.txtCorreo, 'CORREO'),
                SizedBox(height: 15),
                _buildTextField(control.txtCelular, 'CELULAR'),
                SizedBox(height: 15),
                // Menú desplegable de Carrera
                FutureBuilder<List<Carrera>>(
                  future: control.obtenerCarreras(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error al cargar las carreras');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No hay carreras disponibles');
                    }

                    List<Carrera> carreras = snapshot.data!;

                    return Obx(() {
                      return DropdownButton<String>(
                        value: control.selectedCarrera.value.isEmpty ? null : control.selectedCarrera.value,
                        onChanged: (String? newValue) {
                          control.selectedCarrera.value = newValue!;
                        },
                        hint: Text('Selecciona una carrera'),
                        items: carreras.map((Carrera carrera) {
                          return DropdownMenuItem<String>(
                            value: carrera.idCarrera.toString(),
                            child: Text(carrera.nombre),
                          );
                        }).toList(),
                      );
                    });
                  },
                ),
                SizedBox(height: 15),
                // Campo de Contraseña
                _buildPasswordField(control.txtContrasenia),
                SizedBox(height: 20),
                // Botón de Crear
                ElevatedButton(
                  onPressed: () {
                    control.createAccount(context); // Método para crear cuenta
                  },
                  child: Text('Crear cuenta'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(
                        fontFamily: 'Texto',
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/sign-in');
                      },
                      child: Text(
                        'Ingresa',
                        style: TextStyle(
                          fontFamily: 'Texto',
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor, // Color de fondo
    );
  }

  // Método para crear campos de texto
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Texto',
          color: AppColors.primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  // Método para crear campo de contraseña
  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'CONTRASEÑA NUEVA',
        labelStyle: TextStyle(
          fontFamily: 'Texto',
          color: AppColors.primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}
