import 'package:stay_points/src/identification/model/coordinate.dart';
import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
    group('Coordinate validation', () {
        Location location;
        setUp(() {
            var lat = new LocationDegrees(degrees: 41.139129);
            var lon = new LocationDegrees(degrees: 1.402244);
            location = new Location(latitude: lat, longitude: lon);
        });

        test('Having a valid latitude/longitude should return true', () {
            expect(location.isValid, isTrue);
        });

        test('Having a valid latitude but invalid longitude should return false', () {
            var lat = new LocationDegrees(degrees: 0.0);
            var lon = new LocationDegrees(degrees: 270.0);
            location = new Location(latitude: lat, longitude: lon);
            expect(location.isValid, isFalse);
        });

        test('Having a valid longitude but invalid latitude should return false', () {
            var lat = new LocationDegrees(degrees: -122.4612387012154);
            var lon = new LocationDegrees(degrees: 0.0);
            location = new Location(latitude: lat, longitude: lon);
            expect(location.isValid, isFalse);
        });

    });

    group('Latitude validation', () {
        Location location;
        setUp(() {
            var lat = new LocationDegrees(degrees: 41.139129);
            var lon = new LocationDegrees(degrees: 1.402244);
            location = new Location(latitude: lat, longitude: lon);
        });

        test('Having a valid latitude should return true', () {
            expect(location.isValidLatitude, isTrue);
        });

        test('Having and invalid latitude should return false', () {
            var lat = new LocationDegrees(degrees: -122.4612387012154);
            var lon = new LocationDegrees(degrees: 0.0);
            location = new Location(latitude: lat, longitude: lon);

            expect(location.isValidLatitude, isFalse);
        });

    });

    group('Lontitude validation', () {
        Location location;
        setUp(() {
            var lat = new LocationDegrees(degrees: 41.139129);
            var lon = new LocationDegrees(degrees: 1.402244);
            location = new Location(latitude: lat, longitude: lon);
        });

        test('Having a valid longitude should return true', () {
            expect(location.isValidLongitude, isTrue);
        });

        test('Having an invalid lontigutude should return false', () {
            var lat = new LocationDegrees(degrees: 0.0);
            var lon = new LocationDegrees(degrees: 181.0);
            location = new Location(latitude: lat, longitude: lon);

            expect(location.isValidLongitude, isFalse);
        });

    });
}