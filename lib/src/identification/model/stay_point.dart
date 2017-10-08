import 'coordinate.dart';
import 'location.dart';

class StayPoint extends Coordinate {
    DateTime arrival;
    DateTime departure;
    List<Location> locationsInvolved;

    StayPoint({latitude, longitude,
                  this.arrival,
                  this.departure,
                  this.locationsInvolved})
        : super(latitude: latitude, longitude: longitude);

    StayPoint.fromLocations({this.locationsInvolved})
        : this.arrival = locationsInvolved.first.timestamp,
          this.departure = locationsInvolved.last.timestamp,
          super(latitude: sumLatitude(locationsInvolved), longitude: sumLongitude(locationsInvolved));

    Location get location => new Location(latitude: this.latitude, longitude: this.longitude, timestamp: this.departure);

    static LocationDegrees sumLatitude(List<Location> locations) {
        return new LocationDegrees(degrees: locations.fold(0.0, (value, element) => value + element.latitude.degrees));
    }

    static LocationDegrees sumLongitude(List<Location> locations) {
        return new LocationDegrees(degrees: locations.fold(0.0, (value, element) => value + element.longitude.degrees));
    }
}
