import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';


class GlobalProximityListener extends StatefulWidget {
  final Widget child;

  const GlobalProximityListener({super.key, required this.child});

  @override
  _GlobalProximityListenerState createState() =>
      _GlobalProximityListenerState();
}

class _GlobalProximityListenerState extends State<GlobalProximityListener> {
  late StreamSubscription<dynamic> _proximitySubscription;
  bool _isNear = false;

  @override
  void initState() {
    super.initState();
    _proximitySubscription = ProximitySensor.events.listen((event) {
      // Log the raw sensor event for debugging.
      print('Proximity sensor event: $event');

      // Determine near condition. Many devices return 1 (or true) when near.
      bool nearCondition = false;
      nearCondition = (event == 1);

      // Update state only if the sensor state changes.
      if (nearCondition != _isNear) {
        setState(() {
          _isNear = nearCondition;
        });
      }
    });
  }

  @override
  void dispose() {
    _proximitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // When _isNear is true, overlay a full-screen black container
        // to simulate turning off the display.
        if (_isNear)
          IgnorePointer(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
      ],
    );
  }
}