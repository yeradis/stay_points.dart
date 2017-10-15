import 'package:stay_points/stay_points.dart';
import 'resources/sample_data.dart';
import 'package:test/test.dart';

import 'package:units/units.dart';

void main() {
    group('Offline stay-point identification', () {
        StayPointIdentification extractor;

        setUp(() {
            Threshold threshold = new Threshold(
                minimumTime: new Duration(minutes: 4), minimumDistance: new Length.fromMeters(value: 20.0));
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
            expect(extractor.process(locations: [SampleData.sample0_oneStaypoint().first]), isEmpty);
        });

        test('Having same location twice should return empty list', () {
            Location location = SampleData.sample0_oneStaypoint().first;
            expect(extractor.process(locations: [location, location]), isEmpty);
        });

        test('Having same location multiple times should return empty list', () {
            Location location = SampleData.sample0_oneStaypoint().first;
            expect(extractor.process(locations: [location, location, location, location, location]),
                isEmpty);
        });

        test('Having two locations that pass the threshold validation (time, distance) should return 1 stay-point with just one involved location in the calculus', () {
            List<StayPoint> stayPoints = extractor.process(locations: SampleData.sample0_oneStaypoint());
            expect(stayPoints.length, equals(1));
            expect(stayPoints.first.locationsInvolved.length, equals(1));
        }, tags: ["multiple"]);

        test('Should match returned StayPoint - Having two locations that pass the threshold validation (time, distance) returns 1 stay-point with just one involved location in the calculus', () {
            Location location1 = SampleData.sample0_oneStaypoint().first;

            StayPoint stayPoint = new StayPoint(latitude: location1.latitude, longitude: location1.longitude, arrival: location1.timestamp, departure: location1.timestamp, locationsInvolved: [location1]);

            expect(extractor.process(locations: SampleData.sample0_oneStaypoint()),
                equals(predicate((e) =>
                    e is List<StayPoint>
                    && e.first.location.compareTo(stayPoint.location) == 0
                    && e.first.arrival.compareTo(stayPoint.arrival) == 0
                    && e.first.departure.compareTo(stayPoint.departure) == 0
                    && e.first.locationsInvolved.first.compareTo(stayPoint.location) == 0
                )));
        });

        test('Should return ONE StayPoint - Having three locations locations that pass the threshold validation (time, distance) BUT one of those have an invalid coordinate', () {
            expect(extractor.process(locations: SampleData.sample1_oneInvalid_oneStaypoint()).length,equals(1));
        });
    });
}
