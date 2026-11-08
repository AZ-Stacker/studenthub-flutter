import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/models/student.dart';
import 'package:studenthub/providers/student_provider.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final ScrollController _horizontalScrollController = ScrollController();
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List<Student>? _sortedStudents;

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  void _sort(int columnIndex, bool ascending, List<Student> source) {
    final list = List<Student>.of(source);
    list.sort((a, b) {
      final comparison = switch (columnIndex) {
        0 => a.name.compareTo(b.name),
        1 => a.matricNo.compareTo(b.matricNo),
        2 => a.programme.compareTo(b.programme),
        3 => a.cgpa.compareTo(b.cgpa),
        _ => 0,
      };
      return ascending ? comparison : -comparison;
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _sortedStudents = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final students = context.watch<StudentProvider>().students;
    final colors = Theme.of(context).colorScheme;
    final displayList =
        _sortedStudents ??
        (List<Student>.of(students)..sort((a, b) => a.name.compareTo(b.name)));

    return ColoredBox(
      color: const Color.fromARGB(255, 22, 44, 59),
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),
                  // Header block copies the Home page layout: themed avatar,
                  // bold blue title and teal subtitle, so both pages match.
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: colors.primaryContainer,
                    child: Icon(
                      Icons.table_chart_rounded,
                      size: 42,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Student Records',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 106, 255),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Academic performance and programme overview',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color.fromARGB(179, 5, 164, 196),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _MetaChip(
                        icon: Icons.people_outline,
                        label: '${students.length} Records',
                      ),
                      const _MetaChip(
                        icon: Icons.sort,
                        label: 'Tap headers to sort',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // The four columns must fit the card on a phone, so
                        // each one gets an explicit width carved out of the
                        // space left after margins and gaps. Left unbounded,
                        // the table grew to ~674px and put the CGPA column
                        // outside the card, which is what looked cut off.
                        const minTableWidth = 320.0;
                        final availableWidth = constraints.maxWidth;
                        // Wide cards get roomy gaps and larger type; a phone
                        // tightens the same table instead of overflowing it.
                        final roomy = availableWidth >= 620;
                        final gap = roomy ? 18.0 : 8.0;
                        final margin = roomy ? 18.0 : 8.0;
                        final headingSize = roomy ? 12.5 : 11.5;
                        final nameSize = roomy ? 15.0 : 13.0;
                        final bodySize = roomy ? 13.5 : 12.5;
                        final monoSize = roomy ? 13.5 : 12.5;
                        final tableWidth = availableWidth < minTableWidth
                            ? minTableWidth
                            : availableWidth;
                        final columnSpace = tableWidth - 2 * margin - 3 * gap;
                        final nameWidth = columnSpace * (roomy ? 0.26 : 0.30);
                        final matricWidth = columnSpace * (roomy ? 0.18 : 0.19);
                        final programmeWidth =
                            columnSpace * (roomy ? 0.36 : 0.33);
                        final cgpaWidth = columnSpace * (roomy ? 0.20 : 0.18);

                        return Scrollbar(
                          controller: _horizontalScrollController,
                          thumbVisibility: availableWidth < minTableWidth,
                          child: SingleChildScrollView(
                            controller: _horizontalScrollController,
                            scrollDirection: Axis.horizontal,
                            // minWidth only: the table may grow wider than the
                            // card, and the row then scrolls instead of clipping.
                            child: SizedBox(
                              width: tableWidth,
                              child: DataTable(
                                columnSpacing: gap,
                                horizontalMargin: margin,
                                sortColumnIndex: _sortColumnIndex,
                                sortAscending: _sortAscending,
                                headingRowColor: WidgetStateProperty.all(
                                  colors.primaryContainer,
                                ),
                                dividerThickness: 0.8,
                                headingRowHeight: roomy ? 52 : 46,
                                dataRowMinHeight: roomy ? 52 : 48,
                                dataRowMaxHeight: roomy ? 58 : 66,
                                columns: [
                                  DataColumn(
                                    label: _HeadingCell(
                                      label: 'Name',
                                      width: nameWidth,
                                      fontSize: headingSize,
                                      color: colors.onPrimaryContainer,
                                    ),
                                    onSort: (index, ascending) =>
                                        _sort(index, ascending, students),
                                  ),
                                  DataColumn(
                                    label: _HeadingCell(
                                      label: 'Matric',
                                      width: matricWidth,
                                      fontSize: headingSize,
                                      color: colors.onPrimaryContainer,
                                    ),
                                    onSort: (index, ascending) =>
                                        _sort(index, ascending, students),
                                  ),
                                  DataColumn(
                                    label: _HeadingCell(
                                      label: 'Programme',
                                      width: programmeWidth,
                                      fontSize: headingSize,
                                      color: colors.onPrimaryContainer,
                                    ),
                                    onSort: (index, ascending) =>
                                        _sort(index, ascending, students),
                                  ),
                                  DataColumn(
                                    numeric: true,
                                    label: _HeadingCell(
                                      label: 'CGPA',
                                      width: cgpaWidth,
                                      fontSize: headingSize,
                                      align: Alignment.centerRight,
                                      color: colors.onPrimaryContainer,
                                    ),
                                    onSort: (index, ascending) =>
                                        _sort(index, ascending, students),
                                  ),
                                ],
                                rows: displayList.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final student = entry.value;
                                  final isEven = index.isEven;

                                  return DataRow(
                                    color: WidgetStateProperty.all(
                                      isEven
                                          ? Colors.transparent
                                          : colors.primary.withValues(
                                              alpha: 0.09,
                                            ),
                                    ),
                                    cells: [
                                      DataCell(
                                        SizedBox(
                                          width: nameWidth,
                                          child: Text(
                                            student.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: nameSize,
                                              color: colors.onSurface,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: matricWidth,
                                          child: Text(
                                            student.matricNo,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: monoSize,
                                              color: colors.onSurfaceVariant,
                                              fontFamily: 'monospace',
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: programmeWidth,
                                          child: Text(
                                            student.programme,
                                            maxLines: roomy ? 1 : 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: bodySize,
                                              height: 1.3,
                                              color: colors.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: student.cgpa >= 3.50
                                                ? colors.primary
                                                : colors.primary.withValues(
                                                    alpha: 0.08,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: student.cgpa >= 3.50
                                                  ? colors.primary
                                                  : colors.primary.withValues(
                                                      alpha: 0.30,
                                                    ),
                                            ),
                                          ),
                                          child: Text(
                                            student.cgpa.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: bodySize,
                                              color: student.cgpa >= 3.50
                                                  ? colors.onPrimary
                                                  : colors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeadingCell extends StatelessWidget {
  const _HeadingCell({
    required this.label,
    required this.width,
    required this.fontSize,
    required this.color,
    this.align = Alignment.centerLeft,
  });

  final String label;
  final double width;
  final double fontSize;
  final Color color;
  final Alignment align;

  @override
  Widget build(BuildContext context) {
    // Hug the label (widthFactor 1) so the sort arrow DataTable draws next to
    // it sits right against the word instead of drifting to the far right of
    // the column. maxWidth keeps a long label from widening its column.
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: Align(
        alignment: align,
        widthFactor: 1,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            letterSpacing: 0.3,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(
            255,
            255,
            255,
            255,
          ).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color.fromARGB(223, 0, 234, 255)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(223, 0, 234, 255),
            ),
          ),
        ],
      ),
    );
  }
}
