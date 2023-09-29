import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/providers/map_provider.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});
  static const route = 'report_view';
  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(
        height: 140,
        leading: Icon(Icons.arrow_back),
      ),
      body: Center(
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
                decoration: const InputDecoration(
                  label: Text('Dirección'),
                  hintText: 'Ingrese dirección',
                  suffixIcon: Icon(Icons.map),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Fecha'),
                  hintText: 'Ingrese fecha',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Hora'),
                  hintText: 'Ingrese hora',
                ),
              ),
              TextFormField(
                maxLines: 7,
                decoration: const InputDecoration(
                  label: Text('Descripción'),
                  hintText: 'Ingrese descripción del robo',
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await mapProvider.reportZone(context);
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
