import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

import 'package:units/units.dart';
import 'package:stay_points/src/identification/model/accuracy.dart';
import 'resources/sample_data.dart';

void main() {
    group('Online stay-point identification', () {
        final lat1 = 41.139129;
        final lon1 = 1.402244;

        final Location location = new Location.fromDegrees(latitude: lat1,
            longitude: lon1, timestamp: new DateTime.now());

        StayPointIdentification extractor;

        setUp(() {
            Threshold threshold = new Threshold(
                minimumTime: new Duration(minutes: 4),
                minimumDistance: new Length.fromMeters(value: 20.0),
                maxAccuracy: new Accuracy.fromMeters(horizontal: 200.0)
            );
            extractor = new StayPointIdentification(threshold);
        });

        test('Having null should return null', () {
            expect(extractor.processBuffered(location: null), isNull);
        });

        test('Having one location should return null', () {
            expect(extractor.processBuffered(location: location), isNull);
        });

        test('Should return one Stay Point', () {
            List<Location> list = [];
            list.addAll(SampleData.sample1_oneInvalid_oneStaypoint());

            int count = 0;
            for (Location location in list) {
                if (extractor.processBuffered(location: location) != null) {
                    count += 1;
                }
            }
            expect(count, greaterThan(0));
        });


    });
}