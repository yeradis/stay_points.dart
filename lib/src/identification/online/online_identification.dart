import '../model/location.dart';
import '../model/stay_point.dart';
import '../model/threshold.dart';
import '../offline/offline_identification.dart';

import '../extra/location_constraint.dart';
import '../model/location_list.dart';

abstract class OnlineRepository {
    StayPoint process({Threshold threshold, Location location});
}

class OnlineIdentification implements OnlineRepository {
    Threshold threshold;
    LocationList locations = new LocationList();

    @override
    StayPoint process({Threshold threshold, Location location}) {
        this.threshold = threshold;

        locations.add(location);
        if (locations.length <= 1) return null;

        if (!LocationConstraint.considerCurrent(current: location, previous: locations.previous(location))) {
            locations.remove(location);
            return null;
        }

        return processLive();
    }

    StayPoint processLive() {
        OfflineIdentification offline = new OfflineIdentification();
        List<StayPoint> stayPoints = offline.process(threshold: this.threshold, locations: locations);
        if (stayPoints.length > 0) {
            this.locations.removeAll();
            return stayPoints.first;
        }
        return null;
    }
}
