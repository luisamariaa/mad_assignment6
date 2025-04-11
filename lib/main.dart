import 'package:flutter/material.dart';
import 'package:mina_labwork_assign6/map_screen.dart';

void main() {
  runApp(MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MapScreen());
  }
}
