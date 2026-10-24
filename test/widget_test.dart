import 'package:flutter_test/flutter_test.dart';
import 'package:actividad_flutter_completa/main.dart';

void main() {
  testWidgets('La aplicación muestra la pantalla de login', (WidgetTester tester) async {
    await tester.pumpWidget(const TallerApp());
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
