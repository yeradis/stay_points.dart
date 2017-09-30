import 'dart:async';

import '../model/location.dart';
import '../model/stay_point.dart';
import '../model/threshold.dart';

abstract class OnlineRepository {
    Future<StayPoint> process(Threshold Threshold, Location location);
}

class OnlineIdentification implements OnlineRepository {
    @override
    Future<StayPoint> process(Threshold Threshold, Location location) {
        // TODO: implement process
    }
}
