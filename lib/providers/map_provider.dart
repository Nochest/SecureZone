import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tesis_app/models/map_zones.dart';
import 'package:tesis_app/models/report.dart';
import 'package:tesis_app/services/map_report_service.dart';

class MapProvider extends ChangeNotifier {
  MapZone? _mapZone;
  MapZone? get mapZone => _mapZone;
  set mapZone(MapZone? value) {
    _mapZone = value;
    notifyListeners();
  }

  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  set markers(Set<Marker> value) {
    _markers = value;
    notifyListeners();
  }

  Future<void> getMapZones(BuildContext context) async {
    try {
      await MapReporService().getZones().then((value) {
        if (value != null) {
          _mapZone = value;

          _markers = Set.from(_mapZone!.zones.map((e) => Marker(
                markerId: MarkerId(UniqueKey().toString()),
                position: LatLng(
                  double.parse(e.latitud),
                  double.parse(e.longitud),
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  e.color == 'blue'
                      ? BitmapDescriptor.hueBlue
                      : e.color == 'yellow'
                          ? BitmapDescriptor.hueYellow
                          : e.color == 'orange'
                              ? BitmapDescriptor.hueOrange
                              : e.color == 'red'
                                  ? BitmapDescriptor.hueRed
                                  : BitmapDescriptor.hueGreen,
                ),
                infoWindow: InfoWindow(
                  title: e.lugar,
                  snippet: e.modalidad,
                ),
              )));
          notifyListeners();
        } else {
          //TODO: HANDLE EMPTY
        }
      });
    } catch (e) {
      //TODO: HANDLE CATCH
    }
  }

  Future<void> reportZone(
    BuildContext context,
    Report request,
  ) async {
    try {
      await Geolocator.getCurrentPosition().then((r) async {
        await Future.wait([
          MapReporService().reportZone(
            r.latitude.toString(),
            r.longitude.toString(),
            'red',
            request.content,
            request.content,
          ),
          MapReporService().add(request, r.latitude, r.longitude),
        ]).then((value) {
          if (value[0] && value[1]) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Registro exitoso.'),
              backgroundColor: Colors.green,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Error al intetar registrar el reporte, asegurese de llenar todos los datos.',
              ),
              backgroundColor: Colors.red,
            ));
          }
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error desconocido, vuelva a intentarlo.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
