import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tesis_app/models/map_zones.dart';
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
              ))));
          notifyListeners();
        } else {
          //TODO: HANDLE EMPTY
        }
      });
    } catch (e) {
      //TODO: HANDLE CATCH
    }
  }
}
