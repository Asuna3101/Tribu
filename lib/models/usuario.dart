class Usuario {
  int idUsuario;
  String codigo;
  String correo;
  String nombre;
  String celular;
  String foto;
  String contrasena;
  int carreraId;

  // Constructor con los atributos requeridos
  Usuario({
    required this.idUsuario,  // El idUsuario será generado automáticamente en la base de datos
    required this.codigo,
    required this.correo,
    required this.nombre,
    required this.celular,
    required this.foto,
    required this.contrasena,
    required this.carreraId,
  });

  // Método toString para representar la clase como un String
  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, codigo: $codigo, correo: $correo, nombre: $nombre, celular: $celular, foto: $foto, contrasena: $contrasena, carreraId: $carreraId}';
  }

  // Método para convertir la instancia a un Map (útil para bases de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': idUsuario,  // El id se genera automáticamente
      'codigo': codigo,
      'correo': correo,
      'nombre': nombre,
      'celular': celular,
      'foto': foto,
      'contrasenia': contrasena,
      'carrera_id': carreraId,
    };
  }

  // Método para crear una instancia desde un Map (útil para leer de bases de datos)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id'] ?? 0,  // Asignar un valor por defecto si es null
      codigo: map['codigo'] ?? '',
      correo: map['correo'] ?? '',
      nombre: map['nombre'] ?? '',
      celular: map['celular'] ?? '',
      foto: map['foto'] ?? '',
      contrasena: map['contrasenia'] ?? '',
      carreraId: map['carrera_id'] ?? 0, // Asegúrate de manejar los valores nulos
    );
  }

  // Método para convertir la instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'correo': correo,
      'nombre': nombre,
      'celular': celular,
      'foto': foto,
      'contrasena': contrasena,
      'carreraId': carreraId,
    };
  }
}
