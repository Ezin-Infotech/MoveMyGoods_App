// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: FlutterMap(
//       options: const MapOptions(
//         initialCenter: LatLng(51.509364, -0.128928),
//         initialZoom: 9.2,
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           userAgentPackageName: 'com.example.app',
//         ),
//         RichAttributionWidget(
//           attributions: [
//             TextSourceAttribution('OpenStreetMap contributors', onTap: () {}
//                 //  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
//                 ),
//           ],
//         ),
//       ],
//     ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

// class MapWidgets extends StatefulWidget {
//   const MapWidgets({super.key});

//   @override
//   State<MapWidgets> createState() => _MapWidgetsState();
// }

// class _MapWidgetsState extends State<MapWidgets> {
//   String address = '';
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 200,
//             child: Text(address),
//           ),
//           SizedBox(
//             height: 500,
//             child: OpenStreetMapSearchAndPick(
//               // center: const LatLong(23, 89),

//               buttonColor: Colors.blue,
//               buttonText: 'Set Current Location',
//               onPicked: (pickedData) {
//                 setState(() {
//                   address = pickedData.address.toString();
//                 });
//                 print(pickedData.latLong.latitude);
//                 print(pickedData.latLong.longitude);
//                 print(pickedData.address);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
