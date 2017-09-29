import 'dart:async';
import 'model/location.dart';
import 'model/threshold.dart';
import 'identification_repository.dart';
import 'model/stay_point.dart';

class OfflineIdentification implements OfflineRepository {
  @override
  Future<List<StayPoint>> process(Threshold Threshold, List<Location> locations) {
    // TODO: implement process
  }
}
