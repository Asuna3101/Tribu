import 'package:flutter/material.dart';
import 'package:tribu_app/models/calificacion.dart';

class CalificacionCard extends StatelessWidget {
  final Calificacion calificacion;

  const CalificacionCard({Key? key, required this.calificacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(calificacion.fotoUsuario),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      calificacion.nombreUsuario,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      calificacion.carreraUsuario,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(calificacion.resenia),
            const SizedBox(height: 10),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < calificacion.estrella
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha: ${calificacion.fechaSubida}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
