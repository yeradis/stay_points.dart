import 'dart:math';

class LocationDegrees {
    final double degrees;

    LocationDegrees({this.degrees});

    double get inRadians => this.degrees * (PI / 180.0);
}

abstract class Coordinate {
    final LocationDegrees latitude;
    final LocationDegrees longitude;

    Coordinate({this.latitude, this.longitude});

    /// A coordinate is considered invalid if it meets at least one of the following criteria:
    ///
    /// - Its latitude is greater than 90 degrees or less than -90 degrees.
    ///- Its longitude is greater than 180 degrees or less than -180 degrees.
    bool get isValid => isValidLatitude && isValidLongitude;

    /// A latitude is considered invalid if its is greater than 90 degrees or less than -90 degrees.
    bool get isValidLatitude => !(latitude.degrees < -90 || latitude.degrees > 90);
    /// A longitude is considered invalid if its is greater than 180 degrees or less than -180 degrees.
    bool get isValidLongitude => !(longitude.degrees < -180 || longitude.degrees > 180);
}
