import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/models/report.dart';
import 'package:tesis_app/providers/map_provider.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});
  static const route = 'report_view';
  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final addresCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final hourCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        height: 140,
        leading: Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'REGISTERO DE REPORTE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ingrese  la información correspondiente',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: addresCtrl,
                  decoration: const InputDecoration(
                    label: Text('Dirección'),
                    hintText: 'Ingrese dirección',
                    suffixIcon: Icon(Icons.map),
                  ),
                ),
                TextFormField(
                  controller: dateCtrl,
                  decoration: const InputDecoration(
                    label: Text('Fecha'),
                    hintText: 'Ingrese fecha',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final r = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2050),
                    );
                    if (r != null) {
                      setState(() {
                        dateCtrl.text = DateFormat('dd/MM/yyyy').format(r);
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: hourCtrl,
                  decoration: const InputDecoration(
                    label: Text('Hora'),
                    hintText: 'Ingrese hora',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        hourCtrl.text =
                            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: contentCtrl,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    label: Text('Descripción'),
                    hintText: 'Ingrese descripción del robo',
                  ),
                ),
                const SizedBox(height: 64),
                ElevatedButton(
                  onPressed: () async {
                    final request = Report(
                      address: addresCtrl.text,
                      date: dateCtrl.text,
                      hour: hourCtrl.text,
                      content: contentCtrl.text,
                    );
                    inspect(request);
                    await mapProvider.reportZone(context, request);
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
