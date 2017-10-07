import 'dart:math';

class LocationDegrees {
    final double degrees;

    LocationDegrees({this.degrees});

    double toRadians() {
        return this.degrees * (PI / 180.0);
    }
}

abstract class Coordinate {
    final LocationDegrees latitude;
    final LocationDegrees longitude;

    Coordinate({this.latitude, this.longitude});
}
