import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:tesis_app/models/map_zones.dart';
import 'package:http/http.dart' as http;
import 'package:tesis_app/models/report.dart';
import 'package:tesis_app/models/zone_encountered.dart';
import 'package:tesis_app/shared/config/api_client.dart';
import 'package:tesis_app/shared/config/cons.dart';

class MapReporService {
  Future<MapZone?> getZones() async {
    try {
      final r = await http.get(Uri.https(Constants.url, '/zones'));
      if (r.statusCode == 200) {
        return MapZone.fromJson(r.body);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ZoneEncountered?> getCurrentZone(String lat, String lon) async {
    try {
      final r = await http.get(
          Uri.https(
            Constants.url,
            '/classify',
          ),
          headers: {
            'lat': lat,
            'lon': lon,
          });
      if (r.statusCode == 200) {
        return ZoneEncountered.fromJson(r.body);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> reportZone(
    String lat,
    String lon,
    String color,
    String type,
    String content,
  ) async {
    try {
      final r = await http.post(
        Uri.https(Constants.url, '/zones', {
          'lat': lat,
          'lon': lon,
          'color': color,
          'tipo_delito': type,
          'modalidad': content,
        }),
      );
      if (r.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //APPWRITE
  Future<bool> add(Report request, double latitude, double longitude) async {
    try {
      await ApiClient.database.createDocument(
        databaseId: Constants.database,
        collectionId: Constants.collectionReportId,
        documentId: 'unique()',
        data: {
          "address": request.address,
          "date": request.date,
          "hour": request.hour,
          "content": request.content,
          "latitude": latitude,
          "longitude": longitude,
        },
      );
      return true;
    } on AppwriteException catch (e) {
      log(e.message!);
      return false;
    }
  }
}
