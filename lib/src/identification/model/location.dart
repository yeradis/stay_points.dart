import 'dart:math';

import 'coordinate.dart';

class Location extends Coordinate {
    LocationDegrees latitude;
    LocationDegrees longitude;
    DateTime timestamp;

    Location({this.latitude, this.longitude, this.timestamp})
        : super(latitude: latitude, longitude: longitude);

    double distanceTo(Location location) {
        // TODO A port from the Android source code is desired, more accurated and tested
        // https://android.googlesource.com/platform/frameworks/base/+/refs/heads/master/location/java/android/location/Location.java
        // see computeDistanceAndBearing

        // Implementation of the Haversine formula to calculate geographic distance on earth
        // see https://en.wikipedia.org/wiki/Haversine_formula

        double lat1 = latitude.toRadians();
        double lon1 = longitude.toRadians();

        double lat2 = location.latitude.toRadians();
        double lon2 = location.longitude.toRadians();

        var EarthRadius = 6371e3; // metres
        double distance = 2 * EarthRadius * asin(
            sqrt(
                pow(sin(lat2 - lat1) / 2, 2)
                    + cos(lat1)
                    * cos(lat2)
                    * pow(sin(lon2 - lon1) / 2, 2)
            )
        );

        return distance;
    }
}
