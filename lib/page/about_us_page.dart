import 'dart:convert';

import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';


class AboutUsPage extends StatelessWidget {
  AboutUsPage ({super.key});
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(initialCenter: LatLng(47.206, -1.541)),
        mapController: mapController,
        children: [TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        const MarkerLayer(
            markers: [
              Marker(child: Icon(Icons.school), point: LatLng(47.206, -1.541))
              ]
          )
        ]
      ),
    );
  }
}
