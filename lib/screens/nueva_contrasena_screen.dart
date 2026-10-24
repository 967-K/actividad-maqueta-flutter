import 'package:flutter/material.dart';
import '../widgets.dart';

class NuevaContrasenaScreen extends StatefulWidget {
  const NuevaContrasenaScreen({super.key});

  @override
  State<NuevaContrasenaScreen> createState() => _NuevaContrasenaScreenState();
}

class _NuevaContrasenaScreenState extends State<NuevaContrasenaScreen> {
  final contrasena = TextEditingController();
  final confirmar = TextEditingController();
  bool mostrarContrasena = false;
  bool mostrarConfirmacion = false;

  bool get ochoCaracteres => contrasena.text.length >= 8;
  bool get mayuscula => RegExp(r'[A-Z]').hasMatch(contrasena.text);
  bool get numero => RegExp(r'[0-9]').hasMatch(contrasena.text);

  @override
  void dispose() {
    contrasena.dispose();
    confirmar.dispose();
    super.dispose();
  }

  Widget requisito(String texto, bool cumple) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Icon(cumple ? Icons.check_circle : Icons.radio_button_unchecked,
            color: cumple ? Colors.green : colorSuave, size: 20),
        const SizedBox(width: 9),
        Text(texto, style: const TextStyle(color: colorTexto)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coinciden = contrasena.text.isNotEmpty && contrasena.text == confirmar.text;
    final valido = ochoCaracteres && mayuscula && numero && coinciden;
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
                  const SizedBox(height: 16),
                  const Center(child: Icon(Icons.lock_reset_rounded, size: 68, color: colorPrincipal)),
                  const SizedBox(height: 22),
                  const Text('Nueva contraseña', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: colorTexto)),
                  const SizedBox(height: 10),
                  const Text('Código verificado', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 28),
                  entradaTexto(
                    controller: contrasena,
                    etiqueta: 'Nueva contraseña',
                    icono: Icons.lock_outline,
                    ocultar: !mostrarContrasena,
                    onChanged: (_) => setState(() {}),
                    sufijo: IconButton(
                      onPressed: () => setState(() => mostrarContrasena = !mostrarContrasena),
                      icon: Icon(mostrarContrasena ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 16),
                  entradaTexto(
                    controller: confirmar,
                    etiqueta: 'Confirmar contraseña',
                    icono: Icons.lock_outline,
                    ocultar: !mostrarConfirmacion,
                    onChanged: (_) => setState(() {}),
                    sufijo: IconButton(
                      onPressed: () => setState(() => mostrarConfirmacion = !mostrarConfirmacion),
                      icon: Icon(mostrarConfirmacion ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text('La contraseña debe tener:',
                      style: TextStyle(fontWeight: FontWeight.w700, color: colorTexto)),
                  const SizedBox(height: 13),
                  requisito('Al menos 8 caracteres', ochoCaracteres),
                  requisito('Una letra mayúscula', mayuscula),
                  requisito('Un número', numero),
                  requisito('Las contraseñas coinciden', coinciden),
                  const SizedBox(height: 20),
                  botonPrincipal(texto: 'Guardar contraseña', onPressed: valido ? () {
                    mostrarMensaje(context, 'Contraseña actualizada (simulado).');
                    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  } : null),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
