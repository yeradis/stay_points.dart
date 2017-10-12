import 'package:stay_points/stay_points.dart';

class SampleData {
    static List<Location> sample0_oneStaypoint() {
        DateTime date1 = new DateTime(2017, 9, 27, 13, 06, 29);
        Location location1 = new Location.fromDegrees(
            latitude: 41.141903,
            longitude: 1.401316,
            timestamp: date1
        );

        DateTime date3 = new DateTime(2017, 9, 27, 13, 16, 5);
        Location location3 = new Location.fromDegrees(
            latitude: 41.141183,
            longitude: 1.401788,
            timestamp: date3);

        return [location1, location3];
    }

    static List<Location> sample1_oneInvalid_oneStaypoint() {
        DateTime date1 = new DateTime(2017, 9, 27, 13, 06, 29);
        Location location1 = new Location.fromDegrees(
            latitude: 41.141903,
            longitude: 1.401316,
            timestamp: date1
        );

        DateTime date2 = new DateTime(2017, 9, 27, 13, 12, 11);
        Location location2 = new Location.fromDegrees(
            latitude: -122.4612387012154,
            longitude: 1.401788,
            timestamp: date2);

        DateTime date3 = new DateTime(2017, 9, 27, 13, 16, 5);
        Location location3 = new Location.fromDegrees(
            latitude: 41.141183,
            longitude: 1.401788,
            timestamp: date3);

        return [location1, location2, location3];
    }
}