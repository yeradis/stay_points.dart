import 'coordinate.dart';
import 'location.dart';

class StayPoint extends Coordinate {
    LocationDegrees latitude;
    LocationDegrees longitude;

    DateTime arrival;
    DateTime departure;
    List<Location> locationsInvolved;

    StayPoint({this.latitude,
                  this.longitude,
                  this.arrival,
                  this.departure,
                  this.locationsInvolved})
        : super(latitude: latitude, longitude: longitude);

    StayPoint.fromLocations({this.locationsInvolved}) {
        double sumLatitude = 0.0;
        double sumLongitude = 0.0;

        for (Location location in locationsInvolved) {
            sumLatitude += location.latitude.degrees;
            sumLongitude += location.longitude.degrees;
        }

        this.latitude = new LocationDegrees(degrees: sumLatitude);
        this.longitude = new LocationDegrees(degrees: sumLongitude);
        this.arrival = locationsInvolved.first.timestamp;
        this.departure = locationsInvolved.last.timestamp;
        this.locationsInvolved = locationsInvolved;
    }


}
