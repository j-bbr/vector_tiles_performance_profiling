import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapPerformanceOptions {
  final Style style;
  final VectorTileLayerMode layerMode;
  final LatLng center;
  final double zoom;

  MapPerformanceOptions(
      {required this.style,
      this.zoom = 15.0,
      this.center = const LatLng(50, 10),
      this.layerMode = VectorTileLayerMode.vector});
}
