import 'package:test/test.dart';

import 'coordinate_test.dart' as coordinate;
import 'distance_test.dart' as distance;
import 'location_test.dart' as location;
import 'offline_identification_test.dart' as offline;
import 'online_identification_test.dart' as online;
import 'stay_point_test.dart' as staypoint;

void main() {
    group('coordinate', coordinate.main);
    group('distance', distance.main);
    group('location', location.main);
    group('offline', offline.main);
    group('online', online.main);
    group('staypoint', staypoint.main);
}