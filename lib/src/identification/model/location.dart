import 'package:great_circle_distance/great_circle_distance.dart';

import 'coordinate.dart';

class Location extends Coordinate {
    LocationDegrees latitude;
    LocationDegrees longitude;
    DateTime timestamp;

    Location({this.latitude, this.longitude, this.timestamp})
        : super(latitude: latitude, longitude: longitude);

    Duration timeDifference({Location location})  {
        return location.timestamp.difference(location.timestamp);
    }

    double distanceTo(Location location) {
        GreatCircleDistance greatCircle = new GreatCircleDistance.fromDegrees(
            latitude1: latitude.degrees,
            longitude1: longitude.degrees,
            latitude2: location.latitude.degrees,
            longitude2: location.longitude.degrees
        );
        return greatCircle.vincentyDistance();
    }
}
