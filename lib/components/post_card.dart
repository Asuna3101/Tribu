import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribu_app/models/comentarios.dart';
import 'package:tribu_app/services/comentarios_service.dart';
import 'package:tribu_app/services/reaccion_service.dart';

class PostCard extends StatefulWidget {
  final String profilePicUrl;
  final String userName;
  final String userCareer;
  final String postText;
  final String postImageUrl;
  final bool isLiked;
  final int postId;
  final Function onToggleLike;

  const PostCard({
    Key? key,
    required this.profilePicUrl,
    required this.userName,
    required this.userCareer,
    required this.postText,
    required this.postImageUrl,
    required this.isLiked,
    required this.postId,
    required this.onToggleLike,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool _isLiked;
  int totalReacciones = 0;
  final _comentarioController = TextEditingController();
  List<Comentario> comentarios = [];

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _fetchReacciones();
    _loadComentarios();
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  void _fetchReacciones() async {
    try {
      final reacciones = await ReactionService().fetchReacciones(widget.postId);
      setState(() {
        totalReacciones = reacciones.totalLikes;
      });
    } catch (e) {
      print("Error al obtener reacciones: $e");
    }
  }

  void _mostrarReacciones(BuildContext context) async {
    try {
      final reacciones = await ReactionService().fetchReacciones(widget.postId);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Reacciones (${reacciones.totalLikes})'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: reacciones.nombresUsuarios
                .map((nombre) => Text(nombre))
                .toList(),
          ),
        ),
      );
    } catch (e) {
      print("Error al obtener reacciones: $e");
    }
  }

  Future<void> _loadComentarios() async {
    try {
      final loadedComentarios = await ComentarioService().getComentariosByPostId(widget.postId);
      if (loadedComentarios != null) {
        setState(() {
          comentarios = loadedComentarios;
        });
      }
    } catch (e) {
      print("Error al cargar comentarios: $e");
    }
  }

  void _toggleLike() async {
    widget.onToggleLike(widget.postId);

    setState(() {
      _isLiked = !_isLiked;
      totalReacciones += _isLiked ? 1 : -1;
    });
  }

  Future<void> _addComment(String texto) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usuarioId = prefs.getInt('idUsuario');

      if (usuarioId != null && texto.isNotEmpty) {
        final result = await ComentarioService().agregarComentario(
          widget.postId,
          usuarioId,
          texto,
        );

        if (result != null) {
          await _loadComentarios();
          _comentarioController.clear();
        }
      }
    } catch (e) {
      print("Error al agregar comentario: $e");
    }
  }

  void _showComentarios() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comentarios'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _comentarioController,
                          decoration: InputDecoration(
                            hintText: 'Escribe un comentario...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          if (_comentarioController.text.isNotEmpty) {
                            await _addComment(_comentarioController.text);
                            Navigator.of(context).pop();
                            _showComentarios();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: comentarios.isEmpty
                          ? [Text('No hay comentarios aún')]
                          : comentarios.map((comentario) {
                              return ListTile(
                                title: Text(comentario.usuarioNombre),
                                subtitle: Text(comentario.comentarioTexto),
                              );
                            }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.profilePicUrl),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.userCareer),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.postText),
            const SizedBox(height: 10),
            if (widget.postImageUrl.isNotEmpty)
              Image.network(
                widget.postImageUrl,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: _toggleLike,
                ),
                Row(
                  children: [
                    Icon(Icons.add_reaction, color: Colors.red),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => _mostrarReacciones(context),
                      child: Text(
                        '$totalReacciones',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _showComentarios,
                  icon: const Icon(Icons.chat_bubble_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}