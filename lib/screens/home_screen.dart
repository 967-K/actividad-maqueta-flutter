import 'package:flutter/material.dart';
import '../widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    String correo = '';
    String nombre = '¡Bienvenido!';
    if (args is Map) {
      correo = (args['correo'] ?? '').toString();
      final nombreRecibido = (args['nombre'] ?? '').toString();
      if (nombreRecibido.isNotEmpty) nombre = '¡Bienvenido, $nombreRecibido!';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFFEAE9FF),
                  child: Icon(Icons.person_outline, size: 52, color: colorPrincipal),
                ),
                const SizedBox(height: 25),
                Text(nombre, textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: colorTexto)),
                const SizedBox(height: 10),
                Text(correo, textAlign: TextAlign.center,
                    style: const TextStyle(color: colorSuave, fontSize: 15)),
                const SizedBox(height: 30),
                botonPrincipal(
                  texto: 'Cerrar sesión',
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
