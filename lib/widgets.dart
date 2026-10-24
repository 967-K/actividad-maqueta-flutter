import 'package:flutter/material.dart';

const Color colorPrincipal = Color(0xFF635BFF);
const Color colorTexto = Color(0xFF202033);
const Color colorSuave = Color(0xFF77778B);

Widget tituloPantalla(String titulo, String subtitulo) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(titulo,
          style: const TextStyle(
            color: colorTexto,
            fontSize: 28,
            height: 1.2,
            fontWeight: FontWeight.w700,
          )),
      const SizedBox(height: 10),
      Text(subtitulo,
          style: const TextStyle(color: colorSuave, fontSize: 15, height: 1.5)),
    ],
  );
}

Widget botonPrincipal({
  required String texto,
  required VoidCallback? onPressed,
}) {
  return SizedBox(
    height: 54,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorPrincipal,
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFFDAD8FF),
        disabledForegroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(texto,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    ),
  );
}

Widget entradaTexto({
  required TextEditingController controller,
  required String etiqueta,
  required IconData icono,
  TextInputType tipo = TextInputType.text,
  bool ocultar = false,
  Widget? sufijo,
  ValueChanged<String>? onChanged,
}) {
  return TextField(
    controller: controller,
    keyboardType: tipo,
    obscureText: ocultar,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: etiqueta,
      prefixIcon: Icon(icono, color: colorSuave),
      suffixIcon: sufijo,
    ),
  );
}

void mostrarMensaje(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(mensaje), behavior: SnackBarBehavior.floating),
  );
}

bool emailValido(String valor) {
  return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(valor);
}
