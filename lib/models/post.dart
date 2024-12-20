class Post {
  final String nombreUsuario;
  final String fotoUsuario; 
  final String carrera;
  final String descripcionPost;
  final String enlaceMaterial;
  final String fechaSubida;
  final int postId;

  Post({
    required this.nombreUsuario,
    required this.fotoUsuario, 
    required this.carrera,
    required this.descripcionPost,
    required this.enlaceMaterial,
    required this.fechaSubida,
    required this.postId,
  });

  @override
  String toString() {
    return 'Post{nombreUsuario: $nombreUsuario, fotoUsuario: $fotoUsuario, carrera: $carrera, descripcionPost: $descripcionPost, enlaceMaterial: $enlaceMaterial, fechaSubida: $fechaSubida,  postId: $postId}';
                   
  
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre_usuario': nombreUsuario,
      'foto_usuario': fotoUsuario, 
      'carrera': carrera,
      'descripcion_post': descripcionPost,
      'enlace_material': enlaceMaterial,
      'fecha_subida': fechaSubida,
       'post_id': postId,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      nombreUsuario: map['nombre_usuario'],
      fotoUsuario: map['foto_usuario'], 
      carrera: map['carrera'],
      descripcionPost: map['descripcion_post'],
      enlaceMaterial: map['enlace_material'],
      fechaSubida: map['fecha_subida'],
      postId: map['post_id']
    );
  }
}
