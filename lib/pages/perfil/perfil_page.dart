import 'package:flutter/material.dart';
import '../../models/usuario.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recibir los argumentos enviados desde el login
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final usuario = Usuario.fromMap(arguments);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  usuario.foto ?? 'https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre: ${usuario.nombre}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Correo: ${usuario.correo}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Código: ${usuario.codigo}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
