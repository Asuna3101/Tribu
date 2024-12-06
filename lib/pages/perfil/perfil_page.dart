import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/configs/colors.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String? codigo, correo, nombre, celular, foto, carrera;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Cargar los datos del usuario desde SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      codigo = prefs.getString('codigo');
      correo = prefs.getString('correo');
      nombre = prefs.getString('nombre');
      celular = prefs.getString('celular');
      foto = prefs.getString('foto');
      carrera = prefs.getString('carrera');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil de Usuario',
          style: TextStyle(fontFamily: 'Titulo', color: AppColors.primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: codigo == null || nombre == null || correo == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Muestra un cargador mientras se cargan los datos
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Foto de perfil
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: foto != null
                          ? NetworkImage(foto!)
                          : AssetImage('assets/img/sample-profile-image.png')
                              as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    ),
                    SizedBox(height: 20),
                    // Nombre del usuario
                    Text(
                      nombre ?? '',
                      style: TextStyle(
                        fontFamily: 'Titulo',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Información adicional
                    _buildInfoRow(Icons.person, 'Código', codigo),
                    _buildInfoRow(Icons.email, 'Correo', correo),
                    _buildInfoRow(Icons.phone, 'Celular', celular),
                    // _buildInfoRow(
                    //Icons.school, 'Carrera', carrera ?? 'No disponible'),
                  ],
                ),
              ),
            ),
      backgroundColor: AppColors.secondaryColor, // Fondo beige claro
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                value ?? 'No disponible',
                style: TextStyle(
                  fontFamily: 'Texto',
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
