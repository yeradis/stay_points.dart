import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    StayPointIdentification extractor;

    setUp(() {
        Threshold threshold = new Threshold(minimumTime: new Duration(minutes: 4), minimumDistance: 20.0);
        extractor = new StayPointIdentification(threshold);
    });

    test('First Test', () {
      expect(extractor.isAwesome, isTrue);
    });
  });
}
