import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:integration_test/integration_test.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;
import 'package:vector_map_tiles/vector_map_tiles.dart';

import 'package:vector_tiles_performance_profiling/main.dart';
import 'package:vector_tiles_performance_profiling/map_performance_options.dart';
import 'package:vector_tiles_performance_profiling/map_variables.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Move map to points', (tester) async {
    var style = await StyleReader(
            uri: StadiaVariables.styleUri, apiKey: StadiaVariables.apiKey)
        .read();
    // Build our app and trigger a frame.

    await tester.pumpWidget(TestApp(
      options: MapPerformanceOptions(
          style: style,
          zoom: 11,
          layerMode: VectorTileLayerMode.vector,
          center: const LatLng(35.666998, 139.759221)),
    ));

    await binding.traceAction(
      () async {
        var map = find.byType(FlutterMap);
        var zoomInButton = find.byKey(const ValueKey('zoom_in'));
        var zoomOutButton = find.byKey(const ValueKey('zoom_out'));
        await tester.fling(map, const Offset(600, 100), 150);
        await tester.tap(map);
        await tester.tap(map);
        await tester.fling(map, const Offset(-340, 800), 250);
        await tester.tap(zoomOutButton);
        await tester.tap(zoomOutButton);
        await tester.fling(map, const Offset(100, -500), 200);
        await tester.tap(zoomInButton);
      },
      reportKey: 'map_timeline',
    );
  });
}
