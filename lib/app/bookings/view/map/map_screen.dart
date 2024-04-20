// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

class MapScreen extends StatefulWidget {
  final LatLng source;
  final LatLng destination;
  const MapScreen({
    super.key,
    required this.destination,
    required this.source,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = const LatLng(12.2958, 76.6394);
  Marker? currentLocationMarker;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  GoogleMapController? mapController;
  // LatLng? fromLocation;
  // LatLng? destinationLocation;
  bool hasFromLocationBeenSelected = false;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  String userCurrentLocation = 'Fetching...';
  final String _mapStyle = "";

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    updatePolyline();
    main();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pop(context, {'from': fromLocation, 'to': toLocation});
        return true;
      },
      child: Scaffold(
        body: GoogleMap(
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false, mapToolbarEnabled: true,
          buildingsEnabled: true,
          mapType: MapType.terrain,
          initialCameraPosition: const CameraPosition(
            target: LatLng(13.3218116, 77.6731525),
            zoom: 14.555,
          ),

          markers: markers,
          polylines: polylines,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            mapController?.setMapStyle(_mapStyle);
            print("TRY CONNECT ${widget.source}");

            // markers.add(Marker(
            //   markerId: const MarkerId(""),
            //   position: widget.source,
            //   // infoWindow: const InfoWindow(title: 'Starting Point'),
            //   // icon: BitmapDescriptor.defaultMarkerWithHue(
            //   //   BitmapDescriptor.hueCyan,
            //   // ),
            // ));
            // markers.add(Marker(
            //   markerId: const MarkerId("source"),
            //   // icon: sourceIcon,
            //   position: const LatLng(13.0033234, 76.1003894),
            //   icon: BitmapDescriptor.defaultMarkerWithHue(
            //     BitmapDescriptor.hueViolet,
            //   ),
            // ));
            markers.add(Marker(
              markerId: const MarkerId("currentLocation"),
              // icon: sourceIcon,
              position: const LatLng(13.3218116, 77.6731525),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
            ));
            markers.add(Marker(
              markerId: const MarkerId("source"),
              // icon: sourceIcon,
              position: widget.source,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
            ));
            markers.add(Marker(
              markerId: const MarkerId("destination"),
              // icon: destinationIcon,
              position: widget.destination,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ));
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: widget.source,
                  zoom: 15.1746,
                ),
              ),
            );
            updatePolyline();
            setState(() {});
          },
          // onTap: (argument) => onSelectLocation(
          //   argument,
          //   false,
          // ),
        ),
      ),
    );
  }

  Future<int> main() async {
    print('TRY CONNECT 0000000000000000111111111 EXAMPLE::client exception');
    // final client = MqttClient.withPort('http://live.movemygoods.in/', '', 443);
    final client = MqttServerClient('live.movemygoods.in', '');

    client.useWebSocket = false;
    client.port = 443; // ( or whatever your ws port is)
    /// You can also supply your own websocket protocol list or disable this feature using the websocketProtocols
    /// setter, read the API docs for further details here, the vast majority of brokers will support the client default
    /// list so in most cases you can ignore this. Mosquito needs the single default setting.
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
    client.checkCredentials('mmg-live', 'e5SJ7TqxzaZzUGzt3JA225');
    print('TRY CONNECT 111111112222222233333333333 CREEEEEEEEEEEEEEEEEEEEE');

    /// Set logging on if needed, defaults to off
    client.logging(on: true);

    /// Set the correct MQTT protocol for mosquito
    // client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 20;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    // final connMess = MqttConnectMessage()
    //     .withClientIdentifier('Mqtt_MyClientUniqueId')
    //     .withWillTopic(
    //         'willtopic') // If you set this you must set a will message
    //     .withWillMessage('My Will message')
    //     .startClean() // Non persistent session for testing
    //     .withWillQos(MqttQos.atLeastOnce);
    // print('EXAMPLE::Mosquitto client connecting....');
    // client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      print('TRY CONNECT 111111112222222233333333333 TRYYYYYYYYYYYYYYYY');
      await client.connect();
      print('TRY CONNECT 111111112222222233333333333 CONNECTED');
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('TRY CONNECT 11111111 EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('TRY CONNECT 222222222 EXAMPLE::socket exception - $e');
      client.disconnect();
    } catch (e) {
      print('TRY CONNECT 111111112222222233333333333444444444 $e');
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('TRY CONNECT 3333333333 EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'TRY CONNECT 444444444 EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }

    /// Ok, lets try a subscription
    print('TRY CONNECT 55555555555 EXAMPLE::Subscribing to the test/lol topic');
    const topic = '713357890841'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    /// In general you should listen here as soon as possible after connecting, you will not receive any
    /// publish messages until you do this.
    /// Also you must re-listen after disconnecting.
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      /// The above may seem a little convoluted for users only interested in the
      /// payload, some users however may be interested in the received publish message,
      /// lets not constrain ourselves yet until the package has been in the wild
      /// for a while.
      /// The payload is a byte buffer, this will be specific to the topic
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published!.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });

    /// Lets publish to our topic
    /// Use the payload builder rather than a raw buffer
    /// Our known topic to publish to
    const pubTopic = 'Dart/Mqtt_client/testtopic';
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');

    /// Subscribe to it
    print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
    client.subscribe(pubTopic, MqttQos.exactlyOnce);

    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

    /// Ok, we will now sleep a while, in this gap you will see ping request/response
    /// messages being exchanged by the keep alive mechanism.
    print('EXAMPLE::Sleeping....');
    await MqttUtilities.asyncSleep(60);

    /// Finally, unsubscribe and exit gracefully
    print('EXAMPLE::Unsubscribing');
    client.unsubscribe(topic);

    /// Wait for the unsubscribe message from the broker if you wish.
    await MqttUtilities.asyncSleep(2);
    print('EXAMPLE::Disconnecting');
    client.disconnect();
    return 0;
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    // final client = MqttServerClient('live.movemygoods.in/', '');
    // print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    // if (client.connectionStatus!.disconnectionOrigin ==
    //     MqttDisconnectionOrigin.solicited) {
    //   print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    // }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  void updatePolyline() async {
    print("SSSSSSSSSSSSSSSSSSSSSSSSSooooooooooooooone 11111111111111");
    // if (widget.source == null || destinationLocation == null) return;
    List<LatLng> routePoints = await getRouteFromAPI(
      widget.source,
      widget.destination,
    );
    print("SSSSSSSSSSSSSSSSSSSSSSSSSooooooooooooooone 2222222222 $routePoints");
    const String polylineIdVal = 'user_route';
    const PolylineId polylineId = PolylineId(polylineIdVal);
    final Polyline polyline = Polyline(
      startCap: Cap.roundCap,
      polylineId: polylineId,
      points: routePoints,
      width: 5,
      color: Colors.pink[800]!,
    );
    setState(() {
      polylines.removeWhere((poly) => poly.polylineId == polylineId);
      polylines.add(polyline);
    });
    print("SSSSSSSSSSSSSSSSSSSSSSSSSooooooooooooooone");
    adjustCameraToBounds(routePoints, mapController!);
  }

  Future<List<LatLng>> getRouteFromAPI(LatLng start, LatLng end) async {
    String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
    String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';

    String url = '$baseUrl?origin=${start.latitude},${start.longitude}'
        '&destination=${end.latitude},${end.longitude}&key=$apiKey';
    print("SSSSSSSSSSSSSSSSSSSSSSSSSooooooooooooooone 333333333 $url");
    var response = await http.get(Uri.parse(url));
    print("SSSSSSSSSSSSSSSSSSSSSSSSSooooooooooooooone 333333333 $response");
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List steps = data['routes'][0]['legs'][0]['steps'];

      List<LatLng> polylinePoints = [];
      for (var step in steps) {
        var point = step['end_location'];
        polylinePoints.add(LatLng(point['lat'], point['lng']));
      }

      return polylinePoints;
    } else {
      throw Exception('Failed to load directions');
    }
  }

  void adjustCameraToBounds(
      List<LatLng> routePoints, GoogleMapController mapControllers) {
    mapController = mapControllers;
    mapControllers.setMapStyle(_mapStyle);
    if (routePoints.isEmpty) return;
    double southLat = routePoints.map((m) => m.latitude).reduce(min);
    double northLat = routePoints.map((m) => m.latitude).reduce(max);
    double westLng = routePoints.map((m) => m.longitude).reduce(min);
    double eastLng = routePoints.map((m) => m.longitude).reduce(max);
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(southLat, westLng),
      northeast: LatLng(northLat, eastLng),
    );
    mapControllers.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    setState(() {});
  }
}
