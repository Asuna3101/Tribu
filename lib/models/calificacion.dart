class Calificacion {
  final String resenia;
  final int estrella;
  final String fechaSubida;
  final String nombreUsuario;
  final String fotoUsuario;
  final String carreraUsuario;

  Calificacion({
    required this.resenia,
    required this.estrella,
    required this.fechaSubida,
    required this.nombreUsuario,
    required this.fotoUsuario,
    required this.carreraUsuario,
  });

  factory Calificacion.fromMap(Map<String, dynamic> map) {
    return Calificacion(
      resenia: map['resenia'],
      estrella: map['estrella'],
      fechaSubida: map['fecha_subida'],
      nombreUsuario: map['usuario_nombre'],
      fotoUsuario: map['usuario_foto'],
      carreraUsuario: map['carrera_usuario'],
    );
  }

  @override
  String toString() {
    return 'Calificacion(resenia: $resenia, estrella: $estrella, fechaSubida: $fechaSubida, nombreUsuario: $nombreUsuario, fotoUsuario: $fotoUsuario, carreraUsuario: $carreraUsuario)';
  }
}
