import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tiles_performance_profiling/map_performance_options.dart';
import 'package:vector_tiles_performance_profiling/map_variables.dart';

void main() async {
  var style = await StyleReader(
          uri: StadiaVariables.styleUri, apiKey: StadiaVariables.apiKey)
      .read();
  runApp(TestApp(
    performanceOverlay: true,
    options: MapPerformanceOptions(style: style),
  ));
}

class TestApp extends StatelessWidget {
  final bool performanceOverlay;
  final MapPerformanceOptions options;
  const TestApp(
      {super.key, required this.options, this.performanceOverlay = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: performanceOverlay,
      title: 'Flutter Map Profiling',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MapPage(
        options: options,
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  MapPage({super.key, required this.options});

  final MapPerformanceOptions options;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late final animatedMapController = AnimatedMapController(vsync: this);
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var options = widget.options;
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
        ),
        body: Stack(children: [
          FlutterMap(
              mapController: animatedMapController.mapController,
              options: MapOptions(
                initialCenter: options.center,
                initialZoom: options.zoom,
                maxZoom: 22,
              ),
              children: [
                // normally you would see TileLayer which provides raster tiles
                // instead this vector tile layer replaces the standard tile layer
                VectorTileLayer(
                    layerMode: options.layerMode,
                    theme: options.style.theme,
                    sprites: options.style.sprites,
                    // tileOffset: TileOffset.mapbox, enable with mapbox
                    tileProviders: options.style.providers),
              ]),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    key: const ValueKey('zoom_out'),
                    child: const Text(
                      'Zoom Out',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async =>
                        await animatedMapController.animatedZoomTo(
                            animatedMapController.mapController.camera.zoom -
                                2)),
                FloatingActionButton(
                    key: const ValueKey('zoom_in'),
                    child: const Text(
                      'Zoom In',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async =>
                        await animatedMapController.animatedZoomTo(
                            animatedMapController.mapController.camera.zoom +
                                2))
              ],
            ),
          )
        ]));
  }
}
