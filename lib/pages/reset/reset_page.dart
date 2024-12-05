import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/configs/colors.dart';
import 'reset_controller.dart';
import '../../components/custom_button.dart';

class ResetPage extends StatelessWidget {
  final ResetController control = Get.put(ResetController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/adaptive_icon_foreground.png', height: 120.0),
              SizedBox(height: 15),
              Text(
                'Recuperar cuenta',
                style: TextStyle(fontFamily: 'Titulo', fontSize: 22, color: AppColors.primaryColor),
              ),
              SizedBox(height: 20),
              TextField(
                controller: control.txtCorreo,
                decoration: InputDecoration(
                  labelText: 'CORREO',
                  labelStyle: TextStyle(fontFamily: 'Texto', color: AppColors.primaryColor),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                title: 'Buscar',
                onPressed: () {
                  control.resetPassword(context);
                },
              ),
              SizedBox(height: 20),
              Obx(() {
                if (control.userFound.value != null) {
                  return Column(
                    children: [
                      Text(
                        'Usuario encontrado: ${control.userFound.value?.nombre}',
                        style: TextStyle(fontFamily: 'Texto', color: AppColors.primaryColor),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        title: 'Cambiar Contraseña',
                        onPressed: () {
                          control.goToChangePassword();
                        },
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink(); // No mostrar nada si no se encuentra
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(context),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }
}
