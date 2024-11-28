class Profesor {
  int idProfesor;
  String nombre;
  String correo;
  String asignatura;
  String biografia;
  String foto;
  double calificacionPromedio;
  List<double> calificaciones; // Lista de calificaciones individuales

  // Constructor con los atributos requeridos
  Profesor({
    required this.idProfesor,
    required this.nombre,
    required this.correo,
    required this.asignatura,
    required this.biografia,
    required this.foto,
    required this.calificacionPromedio,
    required this.calificaciones,
  });

  // Método toString para representar la clase como un String
  @override
  String toString() {
    return 'Profesor{idProfesor: $idProfesor, nombre: $nombre, correo: $correo, asignatura: $asignatura, biografia: $biografia, foto: $foto, calificacionPromedio: $calificacionPromedio, calificaciones: $calificaciones}';
  }

  // Método para calcular el promedio de calificaciones
  double calcularPromedio() {
    if (calificaciones.isEmpty) return 0.0;
    return calificaciones.reduce((a, b) => a + b) / calificaciones.length;
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
      'calificacionPromedio': calcularPromedio(),
      'calificaciones': calificaciones,
    };
  }

  // Método para crear una instancia de Profesor a partir de un Map
  factory Profesor.fromMap(Map<String, dynamic> map) {
    return Profesor(
      idProfesor: map['idProfesor'],
      nombre: map['nombre'],
      correo: map['correo'],
      asignatura: map['asignatura'],
      biografia: map['biografia'],
      foto: map['foto'],
      calificacionPromedio: map['calificacionPromedio'].toDouble(),
      calificaciones: List<double>.from(map['calificaciones'] ?? []),
    );
  }
}
