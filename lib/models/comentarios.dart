class Comentario {
  final int comentarioId;
  final String comentarioTexto;
  final String usuarioNombre;

  Comentario({
    required this.comentarioId,
    required this.comentarioTexto,
    required this.usuarioNombre,
  });

  // Método para crear un objeto Comentario a partir de un mapa (JSON)
  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(
      comentarioId: map['comentario_id'],
      comentarioTexto: map['comentario_texto'],
      usuarioNombre: map['usuario_nombre'],
    );
  }
}
