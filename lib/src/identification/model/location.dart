import 'package:great_circle_distance/great_circle_distance.dart';

import 'coordinate.dart';

class Location extends Coordinate {
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
}
