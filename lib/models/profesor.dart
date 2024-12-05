class Profesor {
  int idProfesor;
  String nombre;
  String correo;
  List<String> asignaturas;
  String biografia;
  String foto;
  List<double> calificaciones; // Lista de calificaciones individuales

  // Constructor con los atributos requeridos
  Profesor({
    required this.idProfesor,
    required this.nombre,
    required this.correo,
    required this.asignaturas,  // Lista de asignaturas
    required this.biografia,
    required this.foto,
    required this.calificaciones,
  });

  // Método toString para representar la clase como un String
  @override
  String toString() {
    return 'Profesor{idProfesor: $idProfesor, nombre: $nombre, correo: $correo, asignaturas: $asignaturas, biografia: $biografia, foto: $foto, calificaciones: $calificaciones}';
  }

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'idProfesor': idProfesor,
      'nombre': nombre,
      'correo': correo,
      'asignaturas': asignaturas,  // Lista de asignaturas
      'biografia': biografia,
      'foto': foto,
      'calificaciones': calificaciones,
    };
  }

  // Método para crear una instancia de Profesor a partir de un Map
  factory Profesor.fromMap(Map<String, dynamic> map) {
    return Profesor(
      idProfesor: map['idProfesor'] ?? 0,
      nombre: map['nombre'] ?? '',
      correo: map['correo'] ?? '',
      asignaturas: map['asignaturas'] != null
          ? List<String>.from(map['asignaturas'])
          : [],  // Lista vacía si 'asignaturas' es null
      biografia: map['biografia'] ?? '',
      foto: map['foto'] ?? '',
      calificaciones: map['calificaciones'] != null
          ? List<double>.from(map['calificaciones'])
          : [],  // Lista vacía si 'calificaciones' es null
    );
  }
}
