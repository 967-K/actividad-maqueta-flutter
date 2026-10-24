import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets.dart';

class CodigoScreen extends StatefulWidget {
  const CodigoScreen({super.key});

  @override
  State<CodigoScreen> createState() => _CodigoScreenState();
}

class _CodigoScreenState extends State<CodigoScreen> {
  final List<TextEditingController> controladores =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focos = List.generate(4, (_) => FocusNode());
  Timer? temporizador;
  int segundos = 45;
  String correo = '';
  bool argumentosLeidos = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (!argumentosLeidos && args is Map) {
      correo = (args['correo'] ?? '').toString();
      argumentosLeidos = true;
      iniciarTemporizador();
    }
  }

  void iniciarTemporizador() {
    temporizador?.cancel();
    temporizador = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (segundos <= 1) {
        timer.cancel();
        setState(() => segundos = 0);
      } else {
        setState(() => segundos--);
      }
    });
  }

  @override
  void dispose() {
    temporizador?.cancel();
    for (final c in controladores) { c.dispose(); }
    for (final f in focos) { f.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 25),
                  const Center(child: Icon(Icons.shield_outlined, size: 68, color: colorPrincipal)),
                  const SizedBox(height: 24),
                  const Text('Código de verificación', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700, color: colorTexto)),
                  const SizedBox(height: 12),
                  Text('Ingresa el código de 4 dígitos enviado a $correo',
                      textAlign: TextAlign.center, style: const TextStyle(color: colorSuave, height: 1.5)),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (i) => SizedBox(
                      width: 58,
                      child: TextField(
                        controller: controladores[i],
                        focusNode: focos[i],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: const InputDecoration(counterText: '', contentPadding: EdgeInsets.symmetric(vertical: 18)),
                        onChanged: (valor) {
                          if (valor.isNotEmpty && i < 3) {
                            focos[i + 1].requestFocus();
                          } else if (valor.isEmpty && i > 0) {
                            focos[i - 1].requestFocus();
                          }
                        },
                      ),
                    )),
                  ),
                  const SizedBox(height: 18),
                  TextButton(
                    onPressed: segundos == 0 ? () {
                      setState(() => segundos = 45);
                      iniciarTemporizador();
                      mostrarMensaje(context, 'Código reenviado (simulado).');
                    } : null,
                    child: Text(segundos == 0 ? 'Reenviar código'
                        : 'Reenviar código en 00:${segundos.toString().padLeft(2, '0')}'),
                  ),
                  const SizedBox(height: 16),
                  botonPrincipal(texto: 'Verificar código', onPressed: () {
                    final codigo = controladores.map((c) => c.text).join();
                    if (!RegExp(r'^\d{4}$').hasMatch(codigo)) {
                      mostrarMensaje(context, 'Ingresa los 4 dígitos numéricos.');
                    } else {
                      Navigator.pushNamed(context, '/nueva-contrasena',
                          arguments: {'correo': correo});
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
