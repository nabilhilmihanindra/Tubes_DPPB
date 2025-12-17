import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/main.dart';

void main() {
  testWidgets('App loads Sahabat Warga home page',
      (WidgetTester tester) async {

    // Build app
    await tester.pumpWidget(MyApp());

    // Cek apakah judul muncul
    expect(find.text('Sahabat Warga'), findsOneWidget);
    expect(find.text('Aplikasi Sahabat Warga'), findsOneWidget);
  });
}
