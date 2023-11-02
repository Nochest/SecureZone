import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/providers/map_provider.dart';
import 'package:tesis_app/shared/helpers/get_position.dart';
import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/views/emergency_numbers_view.dart';
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
    target: LatLng(
      -11.922794543845349,
      -77.04878777540037,
    ),
    zoom: 14,
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
    // Timer.periodic(const Duration(minutes: 5), (timer) {
    //   mapProvider.getMapZones(context);
    //   Geolocator.getCurrentPosition().then((r) {
    //     if (mapProvider.markers.any((e) =>
    //         Geolocator.distanceBetween(r.latitude, r.longitude,
    //             e.position.latitude, e.position.longitude) <
    //         50)) {
    //       showDialog(
    //           context: context,
    //           builder: (context) {
    //             return AlertDialog(
    //               alignment: Alignment.center,
    //               content: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Image.asset('assets/ic_advertencia.png'),
    //                   const Text(
    //                     '¡ADVERTENCIA!',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                   const Text(
    //                     'Esta cerca de una zona peligrosa',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.w500,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           });
    //       return;
    //     }
    //     log('${r.latitude},${r.longitude}');
    //     log('SERVICE LAUNCHED');
    //   });
    // });

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Animarker(
            mapId: _controller.future.then<int>((value) => value.mapId),
            rippleRadius: 0.5,
            rippleColor: Colors.red,
            rippleDuration: const Duration(milliseconds: 2500),
            duration: const Duration(milliseconds: 2000),
            child: GoogleMap(
              markers: mapProvider.markers,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
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
                          Icon(Icons.warning_amber, size: 48),
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
                      onTap: () => Navigator.pushNamed(
                          context, EmergencyNumbersView.route),
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
                      onTap: () =>
                          Navigator.pushNamed(context, ConfigurationView.route),
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
                child: Row(children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    context.read<AccountProvider>().account?.names ?? '',
                    style: const TextStyle(
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
