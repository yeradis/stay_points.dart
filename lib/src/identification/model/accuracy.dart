class Accuracy {
    final double _horizontal;

    const Accuracy.fromMeters({double horizontal}) : _horizontal = horizontal;

    double get horizontalInMeters => _horizontal;
}