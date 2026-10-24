import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registro_screen.dart';
import 'screens/recuperar_screen.dart';
import 'screens/codigo_screen.dart';
import 'screens/nueva_contrasena_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TallerApp());
}

class TallerApp extends StatelessWidget {
  const TallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ascceso a mi cuenta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF635BFF)),
        scaffoldBackgroundColor: const Color(0xFFF8F8FC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E4EF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E4EF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF635BFF), width: 1.5),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
        '/registro': (_) => const RegistroScreen(),
        '/recuperar': (_) => const RecuperarScreen(),
        '/codigo': (_) => const CodigoScreen(),
        '/nueva-contrasena': (_) => const NuevaContrasenaScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
