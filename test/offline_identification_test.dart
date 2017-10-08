import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
    group('Offline stay-point identification', () {
        final lat1 = 41.139129;
        final lon1 = 1.402244;

        final Location location = new Location.fromDegrees(latitude: lat1,
            longitude: lon1, timestamp: new DateTime.now());

        StayPointIdentification extractor;

        setUp(() {
            Threshold threshold = new Threshold(
                minimumTime: new Duration(minutes: 4), minimumDistance: new Distance(meters: 20.0));
            extractor = new StayPointIdentification(threshold);
        });

        test('Having nil should no throw', () {
            expect(extractor.process(locations: null), isNot(Exception));
        });

        test('Having nil should return something', () {
            expect(extractor.process(locations: null), isNotNull);
        });

        test('Having nil should return empty list', () {
            expect(extractor.process(locations: null), isEmpty);
        });

        test('Having one location should return empty list', () {
            expect(extractor.process(locations: [location]), isEmpty);
        });

        test('Having same location twice should return empty list', () {
            expect(extractor.process(locations: [location, location]), isEmpty);
        });

        test('Having same location multiple times should return empty list', () {
            expect(extractor.process(locations: [location, location, location, location, location]),
                isEmpty);
        });

        test('Having two locations that pass the threshold validation (time, distance) should return 1 stay-point with just one involved location in the calculus', () {

            DateTime date1 = new DateTime(2017, 9, 27, 13, 06, 29);
            Location location1 = new Location.fromDegrees(
                latitude: 41.141903,
                longitude: 1.401316,
                timestamp: date1
            );

            DateTime date2 = new DateTime(2017, 9, 27, 13, 12, 11);
            Location location2 = new Location.fromDegrees(
                latitude: 41.141183,
                longitude: 1.401788,
                timestamp: date2);

            List<StayPoint> stayPoints = extractor.process(locations: [location1, location2]);
            expect(stayPoints.length, equals(1));
            expect(stayPoints.first.locationsInvolved.length, equals(1));
        }, tags: ["multiple"]);

        test('Should match returned StayPoint - Having two locations that pass the threshold validation (time, distance) returns 1 stay-point with just one involved location in the calculus', () {

            DateTime date1 = new DateTime(2017, 9, 27, 13, 06, 29);
            Location location1 = new Location.fromDegrees(
                latitude: 41.141903,
                longitude: 1.401316,
                timestamp: date1
            );

            DateTime date2 = new DateTime(2017, 9, 27, 13, 12, 11);
            Location location2 = new Location.fromDegrees(
                latitude: 41.141183,
                longitude: 1.401788,
                timestamp: date2);

            StayPoint stayPoint = new StayPoint(latitude: location1.latitude, longitude: location1.longitude, arrival: location1.timestamp, departure: location1.timestamp, locationsInvolved: [location1]);

            expect(extractor.process(locations: [location1, location2]),
                equals(predicate((e) =>
                    e is List<StayPoint>
                    && e.first.location.compareTo(stayPoint.location) == 0
                    && e.first.arrival.compareTo(stayPoint.arrival) == 0
                    && e.first.departure.compareTo(stayPoint.departure) == 0
                    && e.first.locationsInvolved.first.compareTo(stayPoint.location) == 0
                )));
        });
    });
}
