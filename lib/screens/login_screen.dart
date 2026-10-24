import 'package:flutter/material.dart';
import '../widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasena = TextEditingController();
  bool mostrarContrasena = false;

  @override
  void dispose() {
    correo.dispose();
    contrasena.dispose();
    super.dispose();
  }

  void iniciarSesion() {
    final email = correo.text.trim();
    if (email.isEmpty || contrasena.text.isEmpty) {
      mostrarMensaje(context, 'Completa todos los campos.');
    } else if (!emailValido(email)) {
      mostrarMensaje(context, 'Escribe un correo electrónico válido.');
    } else {
      Navigator.pushNamed(context, '/home', arguments: {'correo': email});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAE9FF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.bubble_chart_rounded,
                          size: 44, color: colorPrincipal),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text('Bienvenido de nuevo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 29, fontWeight: FontWeight.w700, color: colorTexto)),
                  const SizedBox(height: 9),
                  const Text('Inicia sesión para continuar',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: colorSuave)),
                  const SizedBox(height: 32),
                  entradaTexto(
                    controller: correo,
                    etiqueta: 'Correo electrónico',
                    icono: Icons.mail_outline_rounded,
                    tipo: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  entradaTexto(
                    controller: contrasena,
                    etiqueta: 'Contraseña',
                    icono: Icons.lock_outline_rounded,
                    ocultar: !mostrarContrasena,
                    sufijo: IconButton(
                      onPressed: () => setState(() => mostrarContrasena = !mostrarContrasena),
                      icon: Icon(mostrarContrasena ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/recuperar'),
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  botonPrincipal(texto: 'Iniciar sesión', onPressed: iniciarSesion),
                  const SizedBox(height: 26),
                  const Row(children: [
                    Expanded(child: Divider(color: Color(0xFFE1E1EB))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text('o continúa con', style: TextStyle(color: colorSuave)),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE1E1EB))),
                  ]),
                  const SizedBox(height: 18),
                  Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => mostrarMensaje(context, 'Funcionalidad no disponible'),
                        icon: const Icon(Icons.g_mobiledata, size: 26),
                        label: const Text('Google'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorTexto,
                          side: const BorderSide(color: Color(0xFFE1E1EB)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => mostrarMensaje(context, 'Funcionalidad no disponible'),
                        icon: const Icon(Icons.apple, size: 23),
                        label: const Text('Apple'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorTexto,
                          side: const BorderSide(color: Color(0xFFE1E1EB)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿No tienes cuenta?', style: TextStyle(color: colorSuave)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/registro'),
                        child: const Text('Regístrate', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
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
