import '../model/location.dart';
import '../model/threshold.dart';
import 'package:units/units.dart';

class LocationConstraint{
    /**
        # Apply a simple validation to avoid processing noisy locations

        - Will discard locations with horizontal accuracy greater than the value provided in:
          * provided Threshold Accuracy
          * if nothing provided will take a 200 as MAX
        - Will discard the current location if the sum of the current and previous horizontal accuracy is greater than the value provided in:
          * provided Threshold Accuracy * 2
          * if nothing provided will take a 200 * 2 as MAX
        - Locations wich speed from the last poin to current is greater than the value provided in:
          * provided Threshold Speed
          * if nothing provided will take a speed of 100 m/s = 360 km/h as MAX

        it seems that a horizontal accuracy around 1414m
        is the constant the CLLocationManager gives if it has determined your location based on cell tower triangulation.
        if it has determined your location based on wifi it gives a horizontal accuracy around 65m.
        in both cases, usually there is no vertical acurracy,

        but some times there is some vertical accuracy value
        for wifi its around 10, for cell tower triangulations you can get some values greater than 100

        in my tests i've got from cell tower locations an horizontal accuracy from 1414 to 2000, for vertical around 400
        for wifi, the horizontal accuracy usually is araoun 65 or greater, for vertical usually 10

        this usually happens when you are on a route, for example in the city,
        and then receive a new location from cell tower triangulations with an horizontal accuracy greater then 1000 ()
        causing the fr

     */
    static bool considerCurrent({Location current, Location previous, Threshold threshold}) {
        double maxHorizontalAccuracy = threshold?.maxAccuracy?.horizontalInMeters ?? 200.0;
        double maxSpeed = threshold?.maxSpeed?.inMeterPerSecond ?? 100.0;

        assert(current != null);
        assert(previous != null);

        bool accInRange =  isAccuracyInRange(accuracy: current?.accuracy?.horizontalInMeters ?? 0.0, maxAllowedAccuracy: maxHorizontalAccuracy);
        bool bothAccInrange = locationAccInRange(current: current, previous: previous, maxAllowedAccuracy: maxHorizontalAccuracy);
        bool speedInRange = locationSpeedInRange(current: current, previous: previous, maxAllowedSpeed: maxSpeed);

        return accInRange && bothAccInrange && speedInRange;
    }

    static bool isAccuracyInRange({double accuracy, maxAllowedAccuracy}) {
        if (accuracy == null) return false;
        return accuracy < maxAllowedAccuracy;
    }

    static bool locationAccInRange({Location current, Location previous, double maxAllowedAccuracy}) {
        if (current != null && previous != null) {
            double currentAcc = current?.accuracy?.horizontalInMeters ?? 0.0;
            double previousAcc = previous?.accuracy?.horizontalInMeters ?? 0.0;
            return currentAcc + previousAcc < maxAllowedAccuracy * 2;
        }
        return false;
    }

    static bool locationSpeedInRange({Location current, Location previous, double maxAllowedSpeed}) {
        if (current != null && previous != null) {
            Speed speed = current.speedTo(location: previous);
            return speed != null && speed.inMeterPerSecond < maxAllowedSpeed;
        }
        return false;
    }
}