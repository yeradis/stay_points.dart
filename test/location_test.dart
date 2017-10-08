import 'package:stay_points/stay_points.dart';
import 'package:stay_points/src/identification/model/coordinate.dart';
import 'package:test/test.dart';

void main() {
    group('Distance between locations', () {
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

        test('Distance from location 1 to location 2 - Should return non zero', () {
            expect(location1.distanceTo(location2), isNonZero);
        });

        test('Distance from location 1 to location 2 - Should return non negative', () {
            expect(location1.distanceTo(location2), isNonNegative);
        });

        test('Distance from location1 to same location should be Zero', () {
            expect(location1.distanceTo(location1), isZero);
        });

        test('Distance from location1 to location2 shold be 8.529573134008796', () {
            expect(location1.distanceTo(location2), greaterThanOrEqualTo(8.529573134008796));
        });

        test('Having 41.139129 should return 0.7180 radians', () {
            expect(location1.latitude.inRadians, greaterThanOrEqualTo(0.7180));
        });
        
    });
}