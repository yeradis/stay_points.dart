import '../model/location.dart';
import '../model/stay_point.dart';
import '../model/threshold.dart';

abstract class OfflineRepository {
    List<StayPoint> process({Threshold threshold, List<Location> locations});
}

class OfflineIdentification implements OfflineRepository {

    List<StayPoint> process({Threshold threshold, List<Location> locations}) {
        List<StayPoint> result = [];
        Location locationStart, locationEnd;
        double distance;

        int pStart = 0;
        int pEnd = 0;

        int pCount = locations != null ? locations.length : 0;

        if (pCount <= 1) {
            print("Provided location path is not enough");
            return result;
        }

        while (pStart < pCount) {
            pEnd = pStart + 1;

            while (pEnd < pCount) {
                locationStart = locations[pStart];
                locationEnd = locations[pEnd];

                distance = locationStart.distanceTo(locationEnd);
                bool validated = continueWithCurrent(current: locationEnd, previous: locations[pEnd - 1]);

                if (validated && distance > threshold.minimumDistance.inMeters) {
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
        return result;
    }

    /// used to avoid noise like having the previous location with a a low accuracy
    /// and the current location with a cell tower accuracy > 1400 meters
    /// making the process fail because will pass threshold validation when it should not
    bool continueWithCurrent({Location current,previous}) {
        // TODO add the accuracy value and find a better way to avoid noise
        // example: user entered a tunnel and at exit the locations will have some values that
        // can affect the identification creating a new cluster path
        // this is a very simple approach, a better one can be:
        // distance(newLocation,lastLocation) > location accuracy
        // but this depends on the distance threshold
        //return lastLocation.horizontalAccuracy + newLocation.horizontalAccuracy < 200
        return true;
    }
}
