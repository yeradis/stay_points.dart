import 'dart:collection';
import 'location.dart';

import 'package:units/units.dart';

class LocationList extends ListBase<Location> {
    List innerList = new List();

    int get length => innerList.length;
    void set length(int length) => innerList.length = length;

    void operator[]=(int index, Location value)  => innerList[index] = value;
    Location operator [](int index) => innerList[index];

    void add(Location value) {
        if (value != null  && !value.isValid) return;
        if (innerList.length == 0) {
            innerList.add(value);
        } else {
            var locations = where((Location location) => location.compareIncludingTimestamp(value) == 0).toList();
            if (locations.length == 0) {
                innerList.add(value);
             }
        }
    }

    void addAll(Iterable<Location> all) {
        all.forEach((Location location) => add(location));
    }

    void removeAll() {
        if (innerList.length > 0) {
            innerList.removeWhere(innerList.contains);
        }
    }

    Location next(Location item) {
        int index = indexOf(item);
        if (index != -1 && index + 1 <= length) {
            return index + 1 == length ? elementAt(0) : elementAt(index + 1);
        }
        return null;
    }

    Location previous(Location item) {
        int index = indexOf(item);
        if (index != -1 && index >= 0) {
            return index == 0 ? last : elementAt(index - 1);
        }
        return null;
    }

    Duration globalDuration() {
        if (length ==0) return new Duration(seconds: 0);
        return first.timeDifference(location: last);
    }

    Length globalDistance() {
        if (length ==0) return new Length.fromMeters(value: 0.0);
        return first.distanceTo(location: last);
    }

    /// Calculate speed (instantaneous speed) in an uniform linear motion
    /// which means: constant velocity or zero acceleration
    /// The unit of speed is metre per second
    /// using formula speed = distance / time
    ///
    /// this will be used mainly for validation purpose
    /// to skip/filter locations which speed from the last point to current
    /// is greater than 100 m/s = 360 km/h, this usually happens when taking a walk and
    /// one of the location is reported from cell tower triangulation (horizontal accuracy > 1000)
    /// causing a *teleportation | teletransportation* effect xD
    /// -----------------------|
    /// |          /*|         |  < reported from cell tower triangulation
    /// |         / /  \*\     |  < reported from cell tower triangulation
    /// |       /  /    \ \    |
    /// |* * * *  * * * *  * * *  < route points market with " * "
    /// |                      |
    /// ------------------------
    ///
    Speed globalSpeed() {
        double speed = length == 0 ? 0.0 : globalDistance().inMeters / globalDuration().inSeconds.abs();
        return new Speed.fromMeterPerSecond(value: speed);
    }
}
