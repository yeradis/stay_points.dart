import 'package:stay_points/stay_points.dart';
import 'package:test/test.dart';

void main() {
    group('Online stay-point identification', () {
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

        test('Should return UnimplementedError', () {
            expect(() => extractor.processBuffered(location: location),
                throwsA(predicate((e) => e is UnimplementedError)));
        });
    });
}