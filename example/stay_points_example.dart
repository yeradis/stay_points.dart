import 'package:stay_points/stay_points.dart';

main() {
    Threshold threshold = new Threshold(minimumTime: new Duration(minutes: 4), minimumDistance: 20.0);
    var extractor = new StayPointIdentification(threshold);
}
