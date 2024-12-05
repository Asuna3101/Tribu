class Carrera {
  int idCarrera;
  String nombre;

  // Constructor con los atributos requeridos
  Carrera({
    required this.idCarrera,  // El idCarrera será generado automáticamente en la base de datos
    required this.nombre,
  });

  // Método toString para representar la clase como un String
  @override
  String toString() {
    return 'Carrera{idCarrera: $idCarrera, nombre: $nombre}';
  }

  // Método para convertir la instancia a un Map (útil para bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': idCarrera,  // El id se genera automáticamente
      'nombre': nombre,
    };
  }

  // Método para crear una instancia desde un Map (útil para leer de bases de datos)
  factory Carrera.fromMap(Map<String, dynamic> map) {
    return Carrera(
      idCarrera: map['id'],  // Obtener el id generado por la base de datos
      nombre: map['nombre'],
    );
  }

  // Método para convertir la instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'idCarrera': idCarrera,
      'nombre': nombre,
    };
  }
}
