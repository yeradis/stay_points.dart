import 'package:units/units.dart';
import 'accuracy.dart';

class Threshold {
    final Duration minimumTime;
    final Length minimumDistance;
    final Accuracy maxAccuracy;
    final Speed maxSpeed;

    Threshold({this.minimumTime, this.minimumDistance, this.maxAccuracy, this.maxSpeed});
}