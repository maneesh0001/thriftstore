import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DirectionDetector extends StatefulWidget {
  const DirectionDetector({super.key});

  @override
  State<DirectionDetector> createState() => _DirectionDetectorState();
}

class _DirectionDetectorState extends State<DirectionDetector> {
  // Streams
  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  StreamSubscription<MagnetometerEvent>? _magSubscription;

  // Raw sensor values
  AccelerometerEvent? _accelData;
  MagnetometerEvent? _magData;

  // Computed heading
  double _headingDegrees = 0.0; // 0 = North, 90 = East, 180 = South, 270 = West

  @override
  void initState() {
    super.initState();
    _listenSensors();
  }

  void _listenSensors() {
    _accelSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelData = event;
        _computeHeading();
      });
    });

    _magSubscription = magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magData = event;
        _computeHeading();
      });
    });
  }

  // A simple approach to compute the heading by combining accelerometer + magnetometer.
  void _computeHeading() {
    if (_accelData == null || _magData == null) return;

    // Convert sensor readings to arrays for convenience
    final accel = [_accelData!.x, _accelData!.y, _accelData!.z];
    final mag = [_magData!.x, _magData!.y, _magData!.z];

    // Normalize accelerometer
    final normOfG =
        sqrt(accel[0] * accel[0] + accel[1] * accel[1] + accel[2] * accel[2]);
    accel[0] /= normOfG;
    accel[1] /= normOfG;
    accel[2] /= normOfG;

    // Calculate pitch and roll
    double pitch = asin(-accel[0]);
    double roll = asin(accel[1] / cos(pitch));

    // Tilt compensation for magnetometer
    double x = mag[0] * cos(pitch) + mag[2] * sin(pitch);
    double y = mag[0] * sin(roll) * sin(pitch) +
        mag[1] * cos(roll) -
        mag[2] * sin(roll) * cos(pitch);

    // Compute heading in radians, then convert to degrees
    double heading = atan2(-y, x);
    double headingDegrees = heading * 180 / pi;
    if (headingDegrees < 0) {
      headingDegrees += 360;
    }

    setState(() {
      _headingDegrees = headingDegrees;
    });
  }

  String _getCardinalDirection(double degrees) {
    // A simple approximation for cardinal directions
    if (degrees >= 337.5 || degrees < 22.5) {
      return "N";
    } else if (degrees >= 22.5 && degrees < 67.5) {
      return "NE";
    } else if (degrees >= 67.5 && degrees < 112.5) {
      return "E";
    } else if (degrees >= 112.5 && degrees < 157.5) {
      return "SE";
    } else if (degrees >= 157.5 && degrees < 202.5) {
      return "S";
    } else if (degrees >= 202.5 && degrees < 247.5) {
      return "SW";
    } else if (degrees >= 247.5 && degrees < 292.5) {
      return "W";
    } else {
      return "NW";
    }
  }

  @override
  void dispose() {
    _accelSubscription?.cancel();
    _magSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final directionName = _getCardinalDirection(_headingDegrees);

    return Container(
      padding: const EdgeInsets.all(16),
      width: 250,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Example: a simple arrow or compass dial could be added here
          const Icon(
            Icons.navigation, // "navigation" icon can rotate with heading
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(
            'Heading: ${_headingDegrees.toStringAsFixed(1)}°',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Direction: $directionName',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
