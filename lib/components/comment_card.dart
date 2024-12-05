import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String nombreUsuario;
  final String resenia;
  final int estrella;

  CommentCard({
    required this.nombreUsuario,
    required this.resenia,
    required this.estrella,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            estrella.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(nombreUsuario),
        subtitle: Text(resenia),
      ),
    );
  }
}
