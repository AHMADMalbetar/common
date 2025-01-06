// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class AppGoogleMap extends StatefulWidget {
//   const AppGoogleMap({super.key});
//
//   @override
//   State<AppGoogleMap> createState() => _AppGoogleMapState();
// }
//
// class _AppGoogleMapState extends State<AppGoogleMap> {
//   final Completer<GoogleMapController> controller = Completer();
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//
//   void setCustomMarkerIcon() {
//     BitmapDescriptor.asset(
//       ImageConfiguration.empty,
//       "assets/Location.svg",
//     ).then((icon) {
//       sourceIcon = icon;
//       setState(() {});
//     });
//   }
//
//   List<Map<String, LatLng>> locations = [
//     {'source': const LatLng(37.2074, 37.1440)},
//     {'source1': const LatLng(48.2074, 37.1440)},
//     {'source2': const LatLng(59.2074, 37.1440)},
//     {'source3': const LatLng(60.2074, 37.1440)},
//     {'source4': const LatLng(71.2074, 37.1440)},
//     {'source5': const LatLng(82.2074, 37.1440)},
//   ];
//
//   late Polyline polyline;
//
//   @override
//   void initState() {
//     setCustomMarkerIcon();
//     polyline = Polyline(polylineId: PolylineId('street'), visible: true, points: locations.map((location) => location.values.last).toList());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       scrollGesturesEnabled: true,
//       initialCameraPosition: CameraPosition(target: locations[0].values.last, zoom: 18.5),
//       markers: locations
//           .map(
//             (location) => Marker(
//               icon: sourceIcon,
//               position: location.values.last,
//               markerId: MarkerId(location.keys.first),
//             ),
//           )
//           .toSet(),
//       polylines: {
//         polyline,
//       },
//     );
//   }
// }
