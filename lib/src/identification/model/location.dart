import 'package:great_circle_distance/great_circle_distance.dart';
import 'coordinate.dart';
import 'accuracy.dart';

import 'package:units/units.dart';

class Location extends Coordinate implements Comparable<Location> {
    DateTime timestamp;
    Accuracy accuracy;

    Location({latitude, longitude, this.timestamp})
        : super(latitude: latitude, longitude: longitude);

    Location.fromDegrees({double latitude, double longitude, DateTime timestamp})
        : this.timestamp = timestamp,
            super(latitude: new LocationDegrees(degrees: latitude),
            longitude: new LocationDegrees(degrees: longitude));

    Duration timeDifference({Location location}) {
        return this.timestamp?.difference(location.timestamp);
    }

    Length distanceTo({Location location}) {
        GreatCircleDistance greatCircle = new GreatCircleDistance.fromDegrees(
            latitude1: this.latitude.degrees,
            longitude1: this.longitude.degrees,
            latitude2: location.latitude.degrees,
            longitude2: location.longitude.degrees
        );
        return new Length.fromMeters(value: greatCircle.vincentyDistance());
    }

    Speed speedTo({Location location}) {
        Duration timeDiff = timeDifference(location: location);
        Length lengthDiff = this.distanceTo(location: location);
        if (timeDiff == null || lengthDiff == null) return null;

        return new Speed.fromMeterPerSecond(value: lengthDiff.inMeters / timeDiff.inSeconds.abs());
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
    int compareTo(Location other) =>
        this.latitude.degrees.compareTo(other.latitude.degrees) | this.longitude.degrees.compareTo(
            other.longitude.degrees);

    int compareIncludingTimestamp(Location other) =>
        this.latitude.degrees.compareTo(other.latitude.degrees) | this.longitude.degrees.compareTo(
            other.longitude.degrees) | this.timestamp?.compareTo(other.timestamp);

}
