# Stay Points ![Travis status][travis_status]

Stay points/meaningful locations identification for Dart.

In a nutshell: Stay points are regions where and individual spent a considerable amount of time in a trajectory.

The idea is to be able to extract/identify meaningful locations for the user 
cause that raw location data from GPS is usually meaningless, 
unless you want to draw the route on the map of course.

Example of meaningful locations can be: home, work, fruit shopping, dentist, gym, airport, etc

Note that you will not receive those names, 
you will only get a list of stay points (a coordinate with arrival and departure time) 

The idea is that you pass a full log of GPS data,
then will iterate over the full path to extract candidate locations to form the cluster to create the stay point

Example 1: Cantidate locations to create the stay points
in green the full path, in red the locations that will be part of the stay-point cause they pass the threshold validation
![before stay points](/resources/raw_gps_cluster.png)

Example 2: Stay points
![stay_points](/resources/stay_points.png)

Example of usage:

```dart
main() {
    Threshold threshold = new Threshold(minimumTime: new Duration(minutes: 4), minimumDistance: new Distance(meters: 20.0));

    var extractor = new StayPointIdentification(threshold);
    DateTime date1 = new DateTime(2017, 9, 27, 13, 06, 29);
    Location location1 = new Location.fromDegrees(
        latitude: 41.141903,
        longitude: 1.401316,
        timestamp: date1
    );

    DateTime date2 = new DateTime(2017, 9, 27, 13, 12, 11);
    Location location2 = new Location.fromDegrees(
        latitude: 41.141183,
        longitude: 1.401788,
        timestamp: date2);

    List<StayPoint> stayPoints = extractor.process(locations: [location1, location2]);
    StayPoint first = stayPoints.first;
    int detected = stayPoints.length;
    print("Stay points detected for the provided location path: ${detected}");
    print("First Stay-point detected centroid: ${first.latitude.degrees},${first.longitude.degrees}, arrival: ${first.arrival}, departurde: ${first.departure}");
}
```

Disclaimer: This library is an implementation of the algorithm described in [Quannan Li , Yu Zheng , Xing Xie , Yukun Chen , Wenyu Liu , Wei-Ying Ma, Mining user similarity based on location history, Proceedings of the 16th ACM SIGSPATIAL international conference on Advances in geographic information systems, November 05-07, 2008, Irvine, California  doi>10.1145/1463434.1463477][1] 
http://citeseer.ist.psu.edu/viewdoc/summary?doi=10.1.1.519.9993

[1]: https://doi.org/10.1145/1463434.1463477
[travis_status]: https://travis-ci.org/yeradis/stay_points.dart.svg?branch=master