import 'dart:convert';
import 'dart:io';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/excell/convert_data_to_excel.dart';
import 'package:bills_control/l10n/app_localizations.dart';
import 'package:bills_control/widgets/dev_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

/// Read-only viewer for a closed/archived period (monthly or annual).
/// Items are loaded directly from the JSON file on disk.
class PeriodHistoryViewer extends StatefulWidget {
  const PeriodHistoryViewer({
    Key? key,
    required this.entry,
    required this.budgetName,
  }) : super(key: key);

  final GastosHistorialCerradoData entry;
  final String budgetName;

  @override
  State<PeriodHistoryViewer> createState() => _PeriodHistoryViewerState();
}

class _PeriodHistoryViewerState extends State<PeriodHistoryViewer> {
  List<Map<String, dynamic>> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final file = File(widget.entry.jsonPath);
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> decoded = jsonDecode(content);
        setState(() {
          _items = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAnnual = widget.entry.periodType == 'annual';
    final title = '${widget.budgetName} — ${widget.entry.periodLabel}';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.budgetName,
              style: TextStyle(fontSize: 13.dp, color: Colors.white70),
            ),
            Text(
              '${isAnnual ? l10n.cerrar_anio.replaceAll('Cerrar ', '').replaceAll('Close ', '').replaceAll('Fechar ', '') : l10n.visor_periodo_titulo} ${widget.entry.periodLabel}',
              style: TextStyle(
                fontSize: 16.dp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_open),
            tooltip: l10n.toolTip_export,
            onPressed: () async {
              await exportArchivedPeriod(
                widget.entry,
                widget.budgetName,
                context,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Header: total spent
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.dp,
                      horizontal: 20.dp,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.15),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blueGrey,
                          width: 1.dp,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.total_gastado_label,
                          style: TextStyle(
                            fontSize: 13.dp,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '${widget.entry.totalSpent.toStringAsFixed(2)} \$',
                          style: TextStyle(
                            fontSize: 15.dp,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Read-only info banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 6.dp,
                      horizontal: 20.dp,
                    ),
                    color: Colors.orange.withOpacity(0.08),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline,
                            size: 13.dp, color: Colors.orangeAccent),
                        SizedBox(width: 6.dp),
                        Text(
                          'Solo lectura — periodo archivado',
                          style: TextStyle(
                            fontSize: 11.dp,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Items list
                  Expanded(
                    child: _items.isEmpty
                        ? Center(
                            child: Text(
                              l10n.no_items_history,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              final item = _items[index];
                              DateTime? date;
                              try {
                                date = DateTime.parse(item['date'] ?? '');
                              } catch (_) {}
                              return Container(
                                margin: EdgeInsets.only(
                                  top: 8.dp,
                                  left: 5.dp,
                                  right: 5.dp,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                    width: 1.dp,
                                  ),
                                  borderRadius: BorderRadius.circular(6.dp),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.dp,
                                  horizontal: 16.dp,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['description'] ?? '',
                                            style: TextStyle(
                                              fontSize: 4.5.w,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            item['category'] ?? '',
                                            style: TextStyle(
                                              fontSize: 3.2.w,
                                              color: Colors.white60,
                                            ),
                                          ),
                                          if (date != null)
                                            Text(
                                              '${date.day}/${date.month}/${date.year}',
                                              style: TextStyle(
                                                fontSize: 3.w,
                                                color: Colors.white38,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${(item['amount'] ?? 0).toStringAsFixed(2)} \$',
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: bottomDevName(),
    );
  }
}
