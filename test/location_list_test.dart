import 'package:test/test.dart';
import 'package:stay_points/src/identification/model/location_list.dart';
import 'resources/sample_data.dart';
import 'package:stay_points/stay_points.dart';

void main() {
    group('LocationList tests', () {
        LocationList list;

        setUp(() {
           list = new LocationList();
        });

        test('Having no loctions in list should return 0', () {
            expect(list.length, isZero);
        });

        test('RemoveAll should return normally', () {
            list.addAll(SampleData.sample1_oneInvalid_oneStaypoint());
            expect(list.removeAll(), isNot(throwsA(anything)));
            expect(list.length, isZero);
        });

        test('Next should return normally', () {
            list.addAll(SampleData.sample1_oneInvalid_oneStaypoint());
            expect(list.next(list.first), isNot(throwsA(anything)));
        });

        test('Next on empty list should return null', () {
            expect(list.next(null), isNull);
        });

        test('Previous should return normally', () {
            list.addAll(SampleData.sample1_oneInvalid_oneStaypoint());
            expect(list.previous(list.last), isNot(throwsA(anything)));
        });

        test('Previous on empty list should return null', () {
            expect(list.previous(null), isNull);
        });

        test('Adding 3 locations but 1 invalid in list should return 2', () {
            list.addAll(SampleData.sample1_oneInvalid_oneStaypoint());
            expect(list.length, equals(2));
        });

        test('Having after adding same location (coordinate + timestamp) twice should return 1', () {
            DateTime date = new DateTime(2017, 9, 27, 13, 16, 5);
            Location location = new Location.fromDegrees(
                latitude: 41.141183,
                longitude: 1.401788,
                timestamp: date);

            Location sameLocationOtherObject = new Location.fromDegrees(
                latitude: 41.141183,
                longitude: 1.401788,
                timestamp: date);

            list.add(location);
            list.add(sameLocationOtherObject);

            expect(list.length, equals(1));
        });

    });

    group('LocationList Average calculated speed tests', () {
        LocationList list;

        setUp(() {
            list = new LocationList();
        });

        test('Having no locations in list - avgCalculatedSpeed should return 0.0', () {
            expect(list.globalSpeed().inMeterPerSecond, equals(0.0));
        });

        test('Having some locations - avgCalculatedSpeed should return non zero', () {
            list.addAll(SampleData.sample1_oneInvalid_oneStaypoint());
            expect(list.globalSpeed().inKilometerPerHour, greaterThanOrEqualTo(0.0));
        });

        test('Having two locations with separated by 700 meters reported with a 5 seconds difference- avgCalculatedSpeed should return more than 146 m/s', () {
            DateTime date = new DateTime(2017, 9, 27, 13, 16, 5);
            Location location = new Location.fromDegrees(
                latitude: 41.141454,
                longitude: 1.401322,
                timestamp: date);

            DateTime date1 = new DateTime(2017, 9, 27, 13, 16, 10);
            Location location1 = new Location.fromDegrees(
                latitude: 41.143009,
                longitude: 1.409780,
                timestamp: date1);

            list.addAll([location, location1]);
            expect(location.distanceTo(location: location1).inMeters, greaterThan(730));
            expect(list.globalSpeed().inMeterPerSecond, greaterThan(146));
        });

        test('Having two locations (Barcelona - Madrid) with 8 hours difference - avgCalculatedSpeed should return less than 27 m/s', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);

            DateTime date1 = new DateTime(2017, 9, 27, 15, 16, 10);
            Location location1 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            list.addAll([location, location1]);
            expect(location.distanceTo(location: location1).inMeters, greaterThan(500000));
            expect(list.globalSpeed().inMeterPerSecond, lessThan(27));
        });
  });

    group('LocationList global distance and speed tests', () {
        LocationList list;

        setUp(() {
            list = new LocationList();
        });

        test('Having no loctions in list should return 0', () {
            expect(list.globalSpeed().inMeterPerSecond, equals(0));
            expect(list.globalDistance().inMeters, equals(0));
        });

        test('Having two locations (Barcelona - Madrid) with 8 hours difference - avgCalculatedSpeed should return less than 27 m/s', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);

            DateTime date1 = new DateTime(2017, 9, 27, 15, 16, 10);
            Location location1 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            list.addAll([location, location1]);

            expect(list.globalDistance().inMeters, greaterThan(500000));
            expect(list.globalSpeed().inMeterPerSecond, lessThan(27));
        });
    });
}