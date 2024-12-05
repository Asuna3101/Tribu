import 'package:get/get.dart';
import 'package:tribu_app/models/profesor.dart';
import 'package:tribu_app/services/profesor_service.dart';

class BuscarProfesoresController extends GetxController {
  var profesores = <Profesor>[].obs; // Lista observable de Profesores

  @override
  void onInit() {
    super.onInit();
    cargarProfesores(); // Cargar la lista inicial de profesores
  }

  Future<void> cargarProfesores() async {
    List<Profesor>? resultado = await ProfesorService().getProfesor();
    if (resultado != null) {
      profesores.value = resultado;
    }
  }

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
}


  // Método para obtener un Profesor por su curso QUE VA EN LA PAGINA DE SEARCH
  //Future<List<dynamic>> buscarProfesorPorCurso(String curso) async {
  // Llama al servicio para obtener las Profesors
  //List<dynamic>? profesor = await ProfesorService().getProfesorByCurso(curso);
  //return profesor ?? [];
  //}