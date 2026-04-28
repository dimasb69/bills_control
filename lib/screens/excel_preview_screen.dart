import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ExcelPreviewScreen extends StatelessWidget {
  final List<int> bytes;
  final String filePath;
  final String title;

  const ExcelPreviewScreen({
    super.key,
    required this.bytes,
    required this.filePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var excel = Excel.decodeBytes(bytes);
    final sheets = excel.tables.keys.toList();
    
    return DefaultTabController(
      length: sheets.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 18.dp, fontWeight: FontWeight.bold)),
              Text("Vista previa de Excel", style: TextStyle(fontSize: 12.dp, color: Colors.grey)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_rounded, color: Colors.blue),
              onPressed: () {
                Share.shareXFiles([XFile(filePath)], text: 'Exportación de presupuesto: $title');
              },
              tooltip: "Compartir archivo",
            ),
            const SizedBox(width: 8),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: sheets.map((name) => Tab(text: name)).toList(),
          ),
        ),
        body: TabBarView(
          children: sheets.map((sheetName) {
            var sheet = excel.tables[sheetName]!;
            if (sheet.rows.isEmpty) {
              return const Center(child: Text("Sin datos en esta hoja"));
            }

            final headerRow = sheet.rows.first;
            final dataRows = sheet.rows.skip(1).toList();

            return Container(
              color: Colors.grey.shade50,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: DataTable(
                        headingRowHeight: 45,
                        dataRowHeight: 50,
                        columnSpacing: 25,
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.grey.shade200),
                          verticalInside: BorderSide(color: Colors.grey.shade100),
                        ),
                        columns: headerRow.map((cell) {
                          return DataColumn(
                            label: Text(cell?.value?.toString() ?? ''),
                          );
                        }).toList(),
                        rows: dataRows.map((row) {
                          return DataRow(
                            cells: row.map((cell) {
                              return DataCell(
                                Text(
                                  cell?.value?.toString() ?? '',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
