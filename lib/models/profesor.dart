class Profesor {
  int idProfesor;
  String nombre;
  String correo;
  String asignatura;
  String biografia;
  String foto;
  List<double> calificaciones; // Lista de calificaciones individuales

  // Constructor con los atributos requeridos
  Profesor({
    required this.idProfesor,
    required this.nombre,
    required this.correo,
    required this.asignatura,
    required this.biografia,
    required this.foto,
    required this.calificaciones,
  });

  // Método toString para representar la clase como un String
  @override
  String toString() {
    return 'Profesor{idProfesor: $idProfesor, nombre: $nombre, correo: $correo, asignatura: $asignatura, biografia: $biografia, foto: $foto, calificaciones: $calificaciones}';
  }

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'idProfesor': idProfesor,
      'nombre': nombre,
      'correo': correo,
      'asignatura': asignatura,
      'biografia': biografia,
      'foto': foto,
      'calificaciones': calificaciones,
    };
  }

  // Método para crear una instancia de Profesor a partir de un Map
  factory Profesor.fromMap(Map<String, dynamic> map) {
    return Profesor(
      idProfesor: map['idProfesor'] != null
          ? map['idProfesor']
          : 0, // Si el valor es null, asignamos un valor por defecto (0 o cualquier valor que sea válido)
      nombre: map['nombre'] ??
          '', // Si el nombre es null, asignamos una cadena vacía
      correo: map['correo'] ?? '', // Similar para correo
      asignatura: map['asignatura'] ??
          '', // Si no hay asignatura, asignamos una cadena vacía
      biografia: map['biografia'] ??
          '', // Si no hay biografía, asignamos una cadena vacía
      foto: map['foto'] ?? '', // Si no hay foto, asignamos una cadena vacía
      calificaciones: map['calificaciones'] != null
          ? List<double>.from(map['calificaciones'])
          : [], // Si calificaciones es null, asignamos una lista vacía
    );
  }
}
