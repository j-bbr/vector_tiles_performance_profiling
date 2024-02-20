# vector_tiles_performance_profiling

Profiling project for [flutter-vector-map-tiles](https://github.com/greensopinion/flutter-vector-map-tiles) 
adapted from [Flutter Cookbook](https://docs.flutter.dev/cookbook/testing/integration/profiling).

## Getting Started

Add your styles & api keys under map variables. 
Optionally set the test to a different starting location and zoom.
Then run the following from the package root.
```
flutter drive \
--driver=test_driver/perf_driver.dart \
--target=integration_test/map_interaction_test.dart \
--profile --no-dds -d <YOUR_TESTING_DEVICE>
```
This should result in a timeline.json file
(for use with chrome://tracing) and a json summary file in your build folder.