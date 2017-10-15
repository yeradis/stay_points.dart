import 'package:test/test.dart';

import 'coordinate_test.dart' as coordinate;
import 'location_test.dart' as location;
import 'offline_identification_test.dart' as offline;
import 'online_identification_test.dart' as online;
import 'stay_point_test.dart' as staypoint;
import 'location_list_test.dart' as locationList;
import 'location_validation_test.dart' as locationValidation;

void main() {
    group('coordinate', coordinate.main);
    group('location', location.main);
    group('offline', offline.main);
    group('online', online.main);
    group('staypoint', staypoint.main);
    group('locationList', locationList.main);
    group('locationValidation', locationValidation.main);
}