import 'package:tribu_app/models/usuario.dart';

class Reaccion {
  final int totalLikes;
  final List<String> nombresUsuarios;

  Reaccion({required this.totalLikes, required this.nombresUsuarios});

  @override
  String toString() {
    return 'Reaccion{totalLikes: $totalLikes, usuarios: $nombresUsuarios}';
  }

  // Convierte el objeto Reaccion a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'total_likes': totalLikes,
      'usuarios': nombresUsuarios.map((usuario) => usuario.toString()).toList(),
    };
  }

  // Método para crear un objeto Reaccion desde un mapa (json)
  factory Reaccion.fromMap(Map<String, dynamic> map) {
    // Extraemos solo los nombres de los usuarios de la respuesta
    var list = map['usuarios'] as List;
    List<String> nombresList = list.map((i) => i['usuario']['nombre'] as String).toList();

    return Reaccion(
      totalLikes: map['total_likes'],
      nombresUsuarios: nombresList,
    );
  }
}
