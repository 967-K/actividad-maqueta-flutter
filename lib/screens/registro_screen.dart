import 'package:flutter/material.dart';
import '../widgets.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final nombre = TextEditingController();
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  final confirmar = TextEditingController();
  bool aceptarTerminos = false;
  bool mostrarContrasena = false;
  bool mostrarConfirmacion = false;

  @override
  void dispose() {
    nombre.dispose();
    correo.dispose();
    contrasena.dispose();
    confirmar.dispose();
    super.dispose();
  }

  void crearCuenta() {
    if (nombre.text.trim().isEmpty || correo.text.trim().isEmpty ||
        contrasena.text.isEmpty || confirmar.text.isEmpty) {
      mostrarMensaje(context, 'Completa todos los campos.');
    } else if (!emailValido(correo.text.trim())) {
      mostrarMensaje(context, 'Escribe un correo válido.');
    } else if (contrasena.text != confirmar.text) {
      mostrarMensaje(context, 'Las contraseñas no coinciden.');
    } else if (!aceptarTerminos) {
      mostrarMensaje(context, 'Debes aceptar los términos y condiciones.');
    } else {
      Navigator.pushNamed(context, '/home', arguments: {
        'correo': correo.text.trim(),
        'nombre': nombre.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 8, 26, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  tituloPantalla('Crea tu cuenta', 'Regístrate para comenzar a usar la aplicación.'),
                  const SizedBox(height: 26),
                  entradaTexto(controller: nombre, etiqueta: 'Nombre completo', icono: Icons.person_outline),
                  const SizedBox(height: 15),
                  entradaTexto(controller: correo, etiqueta: 'Correo electrónico',
                      icono: Icons.mail_outline, tipo: TextInputType.emailAddress),
                  const SizedBox(height: 15),
                  entradaTexto(
                    controller: contrasena,
                    etiqueta: 'Contraseña',
                    icono: Icons.lock_outline,
                    ocultar: !mostrarContrasena,
                    sufijo: IconButton(
                      onPressed: () => setState(() => mostrarContrasena = !mostrarContrasena),
                      icon: Icon(mostrarContrasena ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 15),
                  entradaTexto(
                    controller: confirmar,
                    etiqueta: 'Confirmar contraseña',
                    icono: Icons.lock_outline,
                    ocultar: !mostrarConfirmacion,
                    sufijo: IconButton(
                      onPressed: () => setState(() => mostrarConfirmacion = !mostrarConfirmacion),
                      icon: Icon(mostrarConfirmacion ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: aceptarTerminos,
                    title: const Text('Acepto los términos y condiciones', style: TextStyle(fontSize: 14)),
                    onChanged: (valor) => setState(() => aceptarTerminos = valor ?? false),
                  ),
                  const SizedBox(height: 18),
                  botonPrincipal(texto: 'Crear cuenta', onPressed: crearCuenta),
                  const SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('¿Ya tienes cuenta?', style: TextStyle(color: colorSuave)),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Inicia sesión')),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
