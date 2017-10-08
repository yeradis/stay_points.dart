import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
    group('Stay-point', () {
        final lat1 = 41.139129;
        final lon1 = 1.402244;
        final DateTime date = new DateTime.now();
        Location location;

        setUp(() {
            location = new Location.fromDegrees(latitude: lat1,longitude: lon1, timestamp: date);
        });

        test('Locations involved not null after using the basic constructor', () {
            StayPoint stayPoint = new StayPoint(latitude: location.latitude, longitude: location.longitude, arrival: new DateTime.now(), departure: new DateTime.now(), locationsInvolved: [location]);
            expect(stayPoint.locationsInvolved, isNotNull);
        });

        test('Locations involved should return somehitng after using the basic constructor', () {
            StayPoint stayPoint = new StayPoint(latitude: location.latitude, longitude: location.longitude, arrival: new DateTime.now(), departure: new DateTime.now(), locationsInvolved: [location]);
            expect(stayPoint.locationsInvolved.length, greaterThan(0));
        });


        test('StayPoint fromLocations should match values', () {

            StayPoint stayPoint = new StayPoint.fromLocations(locationsInvolved: [location]);

            bool match = stayPoint.location.compareTo(location) == 0
                && stayPoint.arrival.compareTo(date) == 0
                && stayPoint.departure.compareTo(date) == 0
                && stayPoint.locationsInvolved.first.compareTo(location) == 0;

            expect(match, isTrue);
        });

    });
}