import 'package:great_circle_distance/great_circle_distance.dart';

import 'coordinate.dart';

class Location extends Coordinate implements Comparable<Location> {
    DateTime timestamp;

    Location({latitude, longitude, this.timestamp})
        : super(latitude: latitude, longitude: longitude);

    Location.fromDegrees({double latitude, double longitude, DateTime timestamp})
    : this.timestamp = timestamp,
      super(latitude: new LocationDegrees(degrees: latitude), longitude :new LocationDegrees(degrees: longitude));

    Duration timeDifference({Location location})  {
        return this.timestamp.difference(location.timestamp);
    }

    double distanceTo(Location location) {
        GreatCircleDistance greatCircle = new GreatCircleDistance.fromDegrees(
            latitude1: this.latitude.degrees,
            longitude1: this.longitude.degrees,
            latitude2: location.latitude.degrees,
            longitude2: location.longitude.degrees
        );
        return greatCircle.vincentyDistance();
    }

    /**
     * Compares this Location to [other], returning zero if the values are equal.
     *
     * Returns a negative integer if this `Location` is shorter than
     * [other], or a positive integer if it is longer.
     *
     * A negative `Location` is always considered shorter than a positive one.
     *
     */
    int compareTo(Location other) => this.latitude.degrees.compareTo(other.latitude.degrees) | this.longitude.degrees.compareTo(other.longitude.degrees);
}
