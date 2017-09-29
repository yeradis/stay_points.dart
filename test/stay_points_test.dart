import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    StayPointIdentification awesome;

    setUp(() {
      awesome = new StayPointIdentification();
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
