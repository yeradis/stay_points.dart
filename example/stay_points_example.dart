import 'package:stay_points/stay_points.dart';
import 'package:units/units.dart';

main() {
    Threshold threshold = new Threshold(minimumTime: new Duration(minutes: 4), minimumDistance: new Length.fromMeters(value: 20.0));

    var extractor = new StayPointIdentification(threshold);
    DateTime date1 = new DateTime(2017, 9, 27, 13, 06, 29);
    Location location1 = new Location.fromDegrees(
        latitude: 41.141903,
        longitude: 1.401316,
        timestamp: date1
    );

    DateTime date2 = new DateTime(2017, 9, 27, 13, 12, 11);
    Location location2 = new Location.fromDegrees(
        latitude: 41.141183,
        longitude: 1.401788,
        timestamp: date2);

    List<StayPoint> stayPoints = extractor.process(locations: [location1, location2]);
    StayPoint first = stayPoints.first;
    int detected = stayPoints.length;
    print("Stay-points detected for the provided location path: ${detected}");
    print("First Stay-point detected centroid: ${first.latitude.degrees},${first.longitude.degrees}, arrival: ${first.arrival}, departurde: ${first.departure}");
}
