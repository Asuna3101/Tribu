import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribu_app/models/profesor.dart';
import 'package:tribu_app/models/calificacion.dart';
import 'package:tribu_app/services/calificacion_service.dart';
import 'package:tribu_app/components/CalificacionCard.dart';
import 'package:tribu_app/configs/colors.dart';

class PerfilProfesorPage extends StatefulWidget {
  @override
  _PerfilProfesorPageState createState() => _PerfilProfesorPageState();
}

class _PerfilProfesorPageState extends State<PerfilProfesorPage> {
  final CalificacionService calificacionService = CalificacionService();
  List<Calificacion>? calificaciones;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Recupera el objeto 'Profesor' pasado como argumento
    final Profesor profesor = Get.arguments;
    _fetchCalificaciones(
        profesor.idProfesor); // Llama al método para obtener calificaciones
  }

  Future<void> _fetchCalificaciones(int idProfesor) async {
    final data =
        await calificacionService.getCalificacionByProfesorId(idProfesor);
    setState(() {
      calificaciones = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recupera el objeto 'Profesor' pasado como argumento
    final Profesor profesor = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del profesor'),
        titleTextStyle:
            TextStyle(color: Colors.black, fontFamily: 'Titulo', fontSize: 20),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información básica del profesor
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(profesor.foto),
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  profesor.nombre,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Correo: ${profesor.correo}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                'Biografía: ${profesor.biografia}',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              profesor.asignaturas.isNotEmpty
                  ? Text(
                      'Cursos: ${profesor.asignaturas.join(', ')}',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    )
                  : Text(
                      'No tiene cursos asignados.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
              SizedBox(height: 30),

              // Sección de calificaciones
              Text(
                'Calificaciones:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : calificaciones == null || calificaciones!.isEmpty
                      ? Center(
                          child: Text(
                            'No hay calificaciones disponibles.',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: calificaciones!.length,
                          itemBuilder: (context, index) {
                            final calificacion = calificaciones![index];
                            return CalificacionCard(calificacion: calificacion);
                          },
                        ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
    );
  }
}
