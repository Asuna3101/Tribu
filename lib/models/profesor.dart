class Profesor {
  int idProfesor;
  String nombre;
  String correo;
  List<String> asignaturas; // Lista de asignaturas
  String biografia;
  String foto;
  List<double> calificaciones; // Lista de calificaciones individuales

  Profesor({
    required this.idProfesor,
    required this.nombre,
    required this.correo,
    required this.asignaturas, // Lista de asignaturas
    required this.biografia,
    required this.foto,
    required this.calificaciones,
  });

  @override
  String toString() {
    return 'Profesor{idProfesor: $idProfesor, nombre: $nombre, correo: $correo, asignaturas: $asignaturas, biografia: $biografia, foto: $foto, calificaciones: $calificaciones}';
  }

  // Convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'idProfesor': idProfesor,
      'nombre': nombre,
      'correo': correo,
      'asignaturas': asignaturas,
      'biografia': biografia,
      'foto': foto,
      'calificaciones': calificaciones,
    };
  }

  // Crear una instancia de Profesor a partir de un Map
  factory Profesor.fromMap(Map<String, dynamic> map) {
    return Profesor(
      idProfesor: map['profesor_id'] ?? 0,
      nombre: map['nombre'] ?? '',
      correo: map['correo'] ?? '',
      asignaturas: map['cursos'] != null ? map['cursos'].split(',') : [],
      biografia: map['biografia'] ?? '',
      foto: map['foto'] ?? '',
      calificaciones: map['calificaciones'] != null
          ? List<double>.from(map['calificaciones'])
          : [], //
    );
  }
}
