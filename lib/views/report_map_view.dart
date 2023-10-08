import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/providers/map_provider.dart';
import 'package:tesis_app/shared/helpers/get_position.dart';
import 'package:tesis_app/views/profile_view.dart';
import 'package:tesis_app/views/report_view.dart';
import 'package:tesis_app/views/survey_view.dart';

class ReportMapview extends StatefulWidget {
  const ReportMapview({super.key});
  static const route = 'report_map_view';
  @override
  State<ReportMapview> createState() => _ReportMapviewState();
}

class _ReportMapviewState extends State<ReportMapview> {
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-11.922794543845349,
        -77.04878777540037), //Parque Metropolitano SinchiRoca
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await mapProvider.getMapZones(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    mapProvider.getMapZones(context);

    Timer.periodic(const Duration(minutes: 5), (timer) {
      Geolocator.getCurrentPosition().then((r) {
        if (mapProvider.markers.any((e) =>
            Geolocator.distanceBetween(r.latitude, r.longitude,
                e.position.latitude, e.position.longitude) <
            50)) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Zona de peligro'),
                );
              });
          return;
        }
        print('${r.latitude},${r.longitude}');
        print('SERVICE LAUNCHED');
      });
    });

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            markers: mapProvider.markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              GetCurrentPosition().determinePosition().then((value) async {
                _controller.complete(controller);
                final r = await _controller.future;
                r.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(
                    value.latitude,
                    value.longitude,
                  ),
                  zoom: 14.4746,
                )));
              });
            },
            myLocationEnabled: true,
          ),
          Container(
            padding: const EdgeInsets.all(32),
            width: MediaQuery.of(context).size.width - 48,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, ReportView.route),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            size: 48,
                          ),
                          Text(
                            'Reporte',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 48,
                          ),
                          Text(
                            'Informar',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SurveyView.route),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.list_alt,
                            size: 48,
                          ),
                          Text(
                            'Encuesta',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 48,
                          ),
                          Text(
                            'Configuración',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height / 4) - 16,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, ProfileView.route),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width - 16,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'UserName here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
