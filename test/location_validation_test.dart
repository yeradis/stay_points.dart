import 'package:stay_points/stay_points.dart';
import 'package:stay_points/src/identification/model/coordinate.dart';
import 'package:test/test.dart';

import 'package:stay_points/src/identification/model/accuracy.dart';
import 'package:stay_points/src/identification/extra/location_constraint.dart';

void main() {
    group('LocationConstraint tests - evaluate based only in speed (accuracy missing)always validate speed < 100m/s ... and validate accuracy if present < 1000 and sum loc1 + loc2 < 200', () {
        Location location1;
        Location location2;

        setUp(() {
            var lat = new LocationDegrees(degrees: 41.139129);
            var lon = new LocationDegrees(degrees: 1.402244);
            location1 = new Location(latitude: lat, longitude: lon);


            lat = new LocationDegrees(degrees: 41.139074);
            lon = new LocationDegrees(degrees: 1.402315);
            location2 = new Location(latitude: lat, longitude: lon);
        });

        test('locations having no timestamp - Should return false', () {
            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isFalse);
        });

        test('locations with speed less than 100m/s - Should return true', () {

            DateTime date1 = new DateTime(2017, 9, 27, 13, 16, 5);
            DateTime date2 = new DateTime(2017, 9, 27, 13, 16, 10);
            location1.timestamp = date1;
            location2.timestamp = date2;

            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isTrue);
        });
        test('locations with speed greather than 16ms/ and less than 100m/s - Should return true', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location1 = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);

            DateTime date1 = new DateTime(2017, 9, 27, 15, 16, 10);
            Location location2 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            expect(location1.speedTo(location: location2).inMeterPerSecond, greaterThanOrEqualTo(16));
            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isTrue);
        });

        test('locations with speed greather than 100m/s - Should return false', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location1 = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);

            DateTime date1 = new DateTime(2017, 9, 27, 7, 16, 10);
            Location location2 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isFalse);
        });
    });


    group('LocationConstraint tests - evaluate based on horizontal accuracy + speed', () {

        test('Should return false Having accuracy on currentLocation (location1) > 1000', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location1 = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);
            location1.accuracy = new Accuracy.fromMeters(horizontal: 1001.0);

            DateTime date1 = new DateTime(2017, 9, 27, 15, 16, 10);
            Location location2 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            location2.accuracy = new Accuracy.fromMeters(horizontal: 0.0);

            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isFalse);
        });

        test('Should return false - Having accuracy on currentLocation (location1) > 200 && < 1000 cause loc1.accuracy + loc2.accuracy > 200', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location1 = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);
            location1.accuracy = new Accuracy.fromMeters(horizontal: 201.0);

            DateTime date1 = new DateTime(2017, 9, 27, 15, 16, 10);
            Location location2 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            location2.accuracy = new Accuracy.fromMeters(horizontal: 0.0);

            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isFalse);
        });

        test('Should return true - Having the sum of accuracy < 200', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location1 = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);
            location1.accuracy = new Accuracy.fromMeters(horizontal: 99.0);

            DateTime date1 = new DateTime(2017, 9, 27, 15, 16, 10);
            Location location2 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            location1.accuracy = new Accuracy.fromMeters(horizontal: 99.0);

            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isTrue);
        });

        test('Should return false - Having the sum of accuracy < 200 BUT TO MUCH SPEED', () {
            DateTime date = new DateTime(2017, 9, 27, 7, 0, 0);
            Location location1 = new Location.fromDegrees(
                latitude: 41.390205,
                longitude: 2.154007,
                timestamp: date);
            location1.accuracy = new Accuracy.fromMeters(horizontal: 99.0);

            DateTime date1 = new DateTime(2017, 9, 27, 7, 16, 10);
            Location location2 = new Location.fromDegrees(
                latitude: 40.398396,
                longitude: -3.681477,
                timestamp: date1);

            location1.accuracy = new Accuracy.fromMeters(horizontal: 99.0);

            expect(LocationConstraint.considerCurrent(current: location1, previous: location2), isFalse);
        });
    });
}