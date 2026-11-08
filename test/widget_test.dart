import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/main.dart';
import 'package:studenthub/providers/student_provider.dart';

void main() {
  testWidgets('App starts on the home destination', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => StudentProvider(),
        child: const StudentHubApp(),
      ),
    );

    expect(find.text('StudentHub'), findsWidgets);
    expect(find.text('Home'), findsWidgets);
  });
}
