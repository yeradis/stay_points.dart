import 'dart:async';

import '../model/location.dart';
import '../model/stay_point.dart';
import '../model/threshold.dart';

abstract class OfflineRepository {
    Future<List<StayPoint>> process(Threshold threshold, List<Location> locations);
}

class OfflineIdentification implements OfflineRepository {
    @override
    Future<List<StayPoint>> process(Threshold threshold, List<Location> locations) {
        List<StayPoint> result;
        Location locationStart, locationEnd;
        double distance;

        int pStart = 0;
        int pEnd = 0;
        int pCount = locations.length;

        if (pCount <= 1) {
            print("Provided location path is not enough");
            return null;
        }

        while (pStart < pCount) {
            pEnd = pStart + 1;

            while (pEnd < pCount) {
                locationStart = locations[pStart];
                locationEnd = locations[pEnd];

                distance = locationStart.distanceTo(locationEnd);
                bool validated = continueWith(newLocation: locationEnd, lastLocation: locations[pEnd - 1]);

                if (validated && distance > threshold.minimumDistance) {
                    Duration timespan = locationStart.timeDifference(location: locationEnd);

                    if (timespan.inSeconds.abs() > threshold.minimumTime.inSeconds.abs()) {
                        StayPoint stayPoint = new StayPoint.fromLocations(locationsInvolved:locations.sublist(pStart,pEnd));
                        result.add(stayPoint);
                    }

                    pStart = pEnd;
                    break;
                }
                pEnd += 1;
            }
            pStart += 1;
        }
        return new Future(() => result);
    }

    /// used to avoid noise like having location1 with a a low accurancy
    /// and the the next point arrive with a cell tower accuracy > 1400 meters
    bool continueWith({Location newLocation,lastLocation}) {
        //TODO add the accuracy value and find a better way to avoid noise
        //example: user entered a tunnel and at exit the locations will have some values that
        // can affect the identification creating a new cluster path
        //return lastLocation.horizontalAccuracy + newLocation.horizontalAccuracy < 200
        return true;
    }
}
