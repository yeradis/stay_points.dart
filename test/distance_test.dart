import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
    group('Online stay-point identification', () {
        Distance distance20;
        Distance distance4;

        setUp(() {
            distance20 = new Distance(meters: 20.0);
            distance4 = new Distance(meters: 4.0);
        });

        test('Comparing same distance, should return 0 (same distance)', () {
            expect(distance20.compareTo(distance20), equals(0));
        });

        test('Comparing distances, Distance 4 is shorter than Distance 20', () {
            expect(distance4.compareTo(distance20), lessThan(0));
        });

        test('Comparing distances, Distance 20 is greater than Distance 4', () {
            expect(distance20.compareTo(distance4), greaterThan(0));
        });
    });
}