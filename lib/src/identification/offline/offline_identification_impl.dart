import 'dart:async';

import '../model/location.dart';
import '../model/stay_point.dart';
import '../model/threshold.dart';

abstract class OfflineRepository {
    Future<List<StayPoint>> process(Threshold Threshold, List<Location> locations);
}

class OfflineIdentification implements OfflineRepository {
    @override
    Future<List<StayPoint>> process(Threshold Threshold, List<Location> locations) {
        List<StayPoint> result;
        Location locationStart;
        Location locationEnd;
        double distance;
        DateTime timespan;

        int pStart = 0;
        int pEnd = 0;
        int pCount = locations.length;
        bool done = false;

        if (pCount == 0) {
            print("Provided location path is empty");
            return null;
        }

        while (pStart < pEnd) {
            if (done) {
                StayPoint stayPoint = new StayPoint.fromLocations(locationsInvolved: locations);
                result.add(stayPoint);
                break;
            }

            locationStart = locations[pStart];
            pEnd = pStart + 1;

            if (pEnd == pCount) {
                break;
            }

            while (pEnd < pCount) {
                locationEnd = locations[pEnd];
                distance = locationStart.distanceTo(locationEnd);
                // TODO
            }
        }

        return new Future(() => result);
    }
}
