import 'coordinate.dart';
import 'location.dart';

class StayPoint extends Coordinate {
  final double latitude;
  final double longitude;

  final DateTime arrival;
  final DateTime departure;
  final List<Location> locationsInvolved;

  StayPoint(
      {this.latitude,
      this.longitude,
      this.arrival,
      this.departure,
      this.locationsInvolved})
      : super(latitude: latitude, longitude: longitude);
}
