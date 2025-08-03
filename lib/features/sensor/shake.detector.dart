import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

typedef ShakeCallback = void Function();

class ShakeDetector {
  /// The gravity threshold above which a shake is detected.
  final double shakeThresholdGravity;

  /// Minimum time (in milliseconds) between two shake events.
  final int minTimeBetweenShakes;

  /// Callback that is called when a shake is detected.
  final ShakeCallback onPhoneShake;

  StreamSubscription? _accelerometerSubscription;
  int _lastShakeTimestamp = 0;

  ShakeDetector({
    this.shakeThresholdGravity = 2.7,
    this.minTimeBetweenShakes = 1000,
    required this.onPhoneShake,
  });

  void startListening() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      // Normalize acceleration to units of g (gravity)
      double gX = event.x / 9.80665;
      double gY = event.y / 9.80665;
      double gZ = event.z / 9.80665;

      // Compute gForce
      double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

      if (gForce > shakeThresholdGravity) {
        int now = DateTime.now().millisecondsSinceEpoch;
        if (now - _lastShakeTimestamp > minTimeBetweenShakes) {
          _lastShakeTimestamp = now;
          onPhoneShake();
        }
      }
    });
  }

  void stopListening() {
    _accelerometerSubscription?.cancel();
  }
}