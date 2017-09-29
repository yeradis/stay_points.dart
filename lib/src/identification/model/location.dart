import 'coordinate.dart';

class Location extends Coordinate {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  Location({this.latitude, this.longitude, this.timestamp})
      : super(latitude: latitude, longitude: longitude);
}
