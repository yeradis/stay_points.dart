import 'package:stay_points/stay_points.dart';
import 'package:stay_points/src/identification/offline/offline_identification.dart';
import 'package:stay_points/src/identification/online/online_identification.dart';

class StayPointIdentification {
  bool get isAwesome => true;
  final Threshold threshold;
  final OnlineIdentification _online = new OnlineIdentification();

  StayPointIdentification(this.threshold);

  List<StayPoint> process({List<Location> locations}) {
      OfflineIdentification offline = new OfflineIdentification();
      return offline.process(threshold: this.threshold, locations: locations);
  }

  StayPoint processBuffered({Location location}) {
      return _online.process(threshold: this.threshold, location: location);
  }
}
