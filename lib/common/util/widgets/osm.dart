import 'package:common/common/extensions/font_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:shimmer/shimmer.dart';

import 'app_image.dart';

class Osm extends StatelessWidget {
  const Osm({
    super.key,
    required this.controller,
    required this.flag,
  });

  final MapController? controller;
  final String flag;

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller ?? MapController.withUserPosition(),
      osmOption: OSMOption(
        zoomOption: const ZoomOption(
          initZoom: 12,
          maxZoomLevel: 19,
          minZoomLevel: 9,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(
              Icons.location_history,
              color: context.primaryColor,
            ),
          ),
          directionArrowMarker: MarkerIcon(
            iconWidget: AppImage.asset(
              flag,
            ),
          ),
        ),
        roadConfiguration: RoadOption(
          roadColor: context.primaryColor,
          roadWidth: 7,
          zoomInto: false,
          roadBorderColor: Colors.black,
          roadBorderWidth: 1,
        ),
      ),
      mapIsLoading: Center(
        child: SizedBox(
          width: 50, height: 50,
          child: CircularProgressIndicator(
            color: context.primaryColor,
          ),
        ),
      ),
    );
  }
}
