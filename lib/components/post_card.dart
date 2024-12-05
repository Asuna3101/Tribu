import 'package:flutter/material.dart';
import 'package:tribu_app/services/reaccion_service.dart';

class PostCard extends StatefulWidget {
  final String profilePicUrl;
  final String userName;
  final String userCareer;
  final String postText;
  final String postImageUrl;
  final int postId;

  const PostCard({
    Key? key,
    required this.profilePicUrl,
    required this.userName,
    required this.userCareer,
    required this.postText,
    required this.postImageUrl,
    required this.postId,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int totalReacciones = 0;

  @override
  void initState() {
    super.initState();
    _fetchReacciones();
  }

  void _fetchReacciones() async {
    try {
      final reacciones = await ReaccionService().fetchReacciones(widget.postId);
      setState(() {
        totalReacciones = reacciones.totalLikes;
      });
    } catch (e) {
      print("Error al obtener reacciones: $e");
    }
  }

  void _mostrarReacciones(BuildContext context) async {
    try {
      final reacciones =
          await ReaccionService().fetchReacciones(widget.postId);

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
            Image.network(
              widget.postImageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
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
                  onPressed: () {
                    // Otras funcionalidades
                  },
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
