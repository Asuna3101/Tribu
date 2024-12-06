import 'package:get/get.dart';
import 'package:tribu_app/models/calificacion.dart';
import 'package:tribu_app/services/calificacion_service.dart';

class PerfilProfesorController extends GetxController {
  final CalificacionService calificacionService = CalificacionService();
  final isLoading = true.obs;
  final calificaciones = <Calificacion>[].obs;

  Future<void> fetchCalificaciones(int idProfesor) async {
    final data =
        await calificacionService.getCalificacionByProfesorId(idProfesor);
    calificaciones.assignAll(data ?? []);
    isLoading.value = false;
  }
}
