import 'package:flutter/material.dart';
import '../widgets.dart';

class RecuperarScreen extends StatelessWidget {
  const RecuperarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final correo = TextEditingController();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(26),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 35),
                  Center(
                    child: Container(
                      width: 82, height: 82,
                      decoration: BoxDecoration(color: const Color(0xFFEAE9FF),
                          borderRadius: BorderRadius.circular(26)),
                      child: const Icon(Icons.mark_email_read_outlined, size: 42, color: colorPrincipal),
                    ),
                  ),
                  const SizedBox(height: 28),
                  tituloPantalla('Recuperar contraseña',
                      'No te preocupes. Escribe tu correo y te guiaremos para recuperar el acceso.'),
                  const SizedBox(height: 28),
                  entradaTexto(controller: correo, etiqueta: 'Correo electrónico',
                      icono: Icons.mail_outline, tipo: TextInputType.emailAddress),
                  const SizedBox(height: 22),
                  botonPrincipal(texto: 'Enviar código', onPressed: () {
                    final email = correo.text.trim();
                    if (!emailValido(email)) {
                      mostrarMensaje(context, 'Escribe un correo válido.');
                    } else {
                      Navigator.pushNamed(context, '/codigo', arguments: {'correo': email});
                    }
                  }),
                  const SizedBox(height: 18),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('¿La recordaste? Inicia sesión'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
