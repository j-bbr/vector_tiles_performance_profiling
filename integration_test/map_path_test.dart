//Work in progress, for profiling the map along arbitrary paths.

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:geojson_vi/geojson_vi.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:latlong2/latlong.dart';
// import 'dart:math' as math;
// import 'package:vector_map_tiles/vector_map_tiles.dart';
//
// import 'package:vector_tiles_performance_profiling/main.dart';
// import 'package:vector_tiles_performance_profiling/map_performance_options.dart';
// import 'package:vector_tiles_performance_profiling/map_variables.dart';
//
// void main() {
//   final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//
//   testWidgets('Move map to points', (tester) async {
//     var style = await StyleReader(
//             uri: StadiaVariables.styleUri, apiKey: StadiaVariables.apiKey)
//         .read();
//     // Build our app and trigger a frame.
//     await tester
//         .pumpWidget(TestApp(options: MapPerformanceOptions(style: style)));
//     var points = getPaths(
//         '{ "type": "FeatureCollection", "features": [ { "type": "Feature", "properties": {}, "geometry": { "coordinates": [ [ 14.100553318394617, 52.76601366911541 ], [ 12.393430769893854, 51.73881378430775 ], [ 11.180985531918623, 52.76014571579921 ], [ 10.026740326352439, 53.12254680918173 ], [ 8.765792860315116, 52.77775155276336 ], [ 7.669743918884052, 52.02023545106519 ], [ 7.388520715131847, 51.17067815254538 ], [ 7.592195955375473, 50.441280500615136 ], [ 8.930714420351336, 49.78194976117973 ], [ 10.725128445757974, 49.40473040916041 ], [ 13.072354571181364, 49.20240114445144 ], [ 13.935606497949834, 49.981974850118235 ], [ 14.149027410810902, 51.26181176889341 ], [ 13.644684343399717, 52.37694593960353 ] ], "type": "LineString" } } ] }');
//     points = interpolatePoints(points, 1500).toList(growable: false);
//     await binding.traceAction(
//       () async {
//         // Scroll until the item to be found appears.
//         await moveMapToPoints(tester, points, 10);
//       },
//       reportKey: 'map_timeline',
//     );
//   });
// }
//
// Future<void> moveMapToPoints(
//   WidgetTester tester,
//   Iterable<LatLng> points,
//   double zoom, {
//   Duration duration = const Duration(milliseconds: 50),
// }) {
//   return TestAsyncUtils.guard<void>(() async {
//     final oldCallback = FlutterError.onError;
//     FlutterError.onError = (details) {/* do nothing on purpose */};
//     await tester.pump();
//     final mapPage = tester.widget<MapPage>(find.byType(MapPage));
//     for (var point in points) {
//       // mapPage.controller.move(point, zoom);
//
//       await tester.pump();
//     }
//     FlutterError.onError = oldCallback;
//   });
// }
//
// Iterable<LatLng> getPaths(String json) sync* {
//   final features = GeoJSONFeatureCollection.fromJSON(json);
//   var lineStrings = features.features
//       .map((feature) => feature?.geometry)
//       .whereType<GeoJSONLineString>();
//   yield* lineStrings
//       .expand((lineString) => lineString.coordinates)
//       .map(toLatLng);
// }
//
// Iterable<LatLng> interpolatePoints(
//     Iterable<LatLng> base, double speedInMetersPerSecond) {
//   return Path.from(base)
//       .equalize(speedInMetersPerSecond, smoothPath: true)
//       .coordinates;
// }
//
// LatLng toLatLng(List<double> coordinates) {
//   return LatLng(coordinates[1], coordinates[0]);
// }
