/*import 'package:get/get.dart';
import 'package:tribu_app/models/profesor.dart';

class ProfesorController extends GetxController {
  var profesor = Rxn<Profesor>();

  @override
  void onInit() {
    super.onInit();
    fetchProfesor();
  }

  void fetchProfesor() {
    profesor.value = Profesor(
      idProfesor: 1,
      nombre: "Valdivia Jose",
      correo: "valdivia@correo.com",
      asignatura: "Programación móvil",
      biografia: "Docente de amplia experiencia...",
      foto: "https://via.placeholder.com/150",
      calificacionPromedio: 4.5, // Promedio inicial
      calificaciones: [5.0, 4.0, 4.5], // Lista de calificaciones individuales
    );
  }

  void agregarCalificacion(double nuevaCalificacion) {
    profesor.value?.calificaciones.add(nuevaCalificacion);
    profesor.value?.calificacionPromedio =
        profesor.value?.calcularPromedio() ?? 0.0; // Recalcular promedio
    profesor.refresh(); // Notificar que los datos han cambiado
  }
}
*/