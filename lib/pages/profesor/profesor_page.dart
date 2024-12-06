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
    _fetchCalificaciones(profesor.idProfesor);
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Perfil del profesor'),
        titleTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontFamily: 'Titulo',
          fontSize: 20,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              const SizedBox(height: 20),
              Center(
                child: Text(
                  profesor.nombre,
                  style: TextStyle(
                    fontFamily: 'Titulo',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Texto',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Correo: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: profesor.correo),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Texto',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Biografía: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: profesor.biografia),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Texto',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Cursos: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: profesor.asignaturas.isNotEmpty
                          ? profesor.asignaturas.join(', ')
                          : 'No tiene cursos asignados.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Botón "Calificar"
             Center(
  child: ElevatedButton(
    onPressed: () async {
      final resultado = await Navigator.of(context).pushNamed(
        '/calificar',
        arguments: {
          'idProfesor': profesor.idProfesor,
          'nombreProfesor': profesor.nombre,
        },
      );

      if (resultado == true) {
        // Actualiza las calificaciones del profesor después de calificar
        _fetchCalificaciones(profesor.idProfesor);
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
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
              const SizedBox(height: 20),
              // Sección de calificaciones
              Text(
                'Calificaciones:',
                style: TextStyle(
                  fontFamily: 'Titulo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : calificaciones == null || calificaciones!.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay calificaciones disponibles.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
