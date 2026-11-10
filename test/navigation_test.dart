import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studenthub/main.dart';
import 'package:studenthub/pages/home_page.dart';
import 'package:studenthub/pages/records_page.dart';
import 'package:studenthub/pages/student_list_page.dart';

void main() {
  testWidgets('Bottom bar and drawer change the page through the provider', (
    tester,
  ) async {
    await tester.pumpWidget(const StudentHubApp());
    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.table_chart).last);
    await tester.pumpAndSettle();
    expect(find.byType(RecordsPage), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Student Information'));
    await tester.pumpAndSettle();
    expect(find.byType(StudentListPage), findsOneWidget);
  });
}
