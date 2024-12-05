import 'package:get/get.dart';
import 'package:tribu_app/models/profesor.dart';
import 'package:tribu_app/models/calificacion.dart';
import 'package:tribu_app/services/profesor_service.dart';
import 'package:tribu_app/services/calificacion_service.dart';

class BuscarProfesoresController extends GetxController {
  var profesores = <Profesor>[].obs; // Lista observable de Profesores
  var calificaciones =
      <Calificacion>[].obs; // Lista observable de Calificaciones
  var isLoadingCalificaciones =
      false.obs; // Indicador de carga para calificaciones

  @override
  void onInit() {
    super.onInit();
    cargarProfesores(); // Cargar la lista inicial de profesores
  }

  // Método para cargar todos los profesores
  Future<void> cargarProfesores() async {
    List<Profesor>? resultado = await ProfesorService().getProfesor();
    if (resultado != null) {
      profesores.value = resultado;
    }
  }

  // Método para buscar un profesor por nombre
  Future<void> buscarProfesorPorNombre(String nombre) async {
    if (nombre.isEmpty) {
      cargarProfesores(); // Si no se ingresa nada, recarga todos los profesores
    } else {
      List<dynamic>? resultado =
          await ProfesorService().getProfesorByName(nombre);
      if (resultado != null) {
        profesores.value = resultado
            .map((e) => Profesor.fromMap(e))
            .toList(); // Mapea resultados
      } else {
        profesores.clear(); // Limpia la lista si no hay resultados
      }
    }
  }

  // Método para obtener calificaciones por el ID del profesor
  Future<void> cargarCalificaciones(int idProfesor) async {
    try {
      isLoadingCalificaciones.value = true; // Activa el indicador de carga
      List<Calificacion>? resultado =
          await CalificacionService().getCalificacionByProfesorId(idProfesor);

      if (resultado != null) {
        calificaciones.value = resultado;
      } else {
        calificaciones.clear(); // Limpia la lista si no hay resultados
      }
    } catch (e) {
      print('Error al cargar calificaciones: $e');
      calificaciones.clear(); // Limpia la lista en caso de error
    } finally {
      isLoadingCalificaciones.value = false; // Desactiva el indicador de carga
    }
  }
}
