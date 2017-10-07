import 'dart:async';

import '../model/location.dart';
import '../model/stay_point.dart';
import '../model/threshold.dart';

abstract class OnlineRepository {
    StayPoint process({Threshold threshold, Location location});
}

class OnlineIdentification implements OnlineRepository {
    @override
    StayPoint process({Threshold threshold, Location location}) {
        throw new UnimplementedError("Not yet implemented");
    }
}
