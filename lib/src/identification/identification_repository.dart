import 'dart:async';
import 'package:stay_points/stay_points.dart';

abstract class OnlineRepository {
  Future<StayPoint> process(Threshold Threshold, Location location);
}

abstract class OfflineRepository {
  Future<List<StayPoint>> process(Threshold Threshold, List<Location> locations);
}

