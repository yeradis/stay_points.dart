class Distance implements Comparable<Distance> {
    /*
   * The value of this Distance object in meters.
   */
    final double _distance;

    const Distance({double meters : 0.0}) : _distance = meters;

    /**
     * Compares this Distance to [other], returning zero if the values are equal.
     *
     * Returns a negative integer if this `Distance` is shorter than
     * [other], or a positive integer if it is longer.
     *
     * A negative `Distance` is always considered shorter than a positive one.
     *
     */
    int compareTo(Distance other) => _distance.compareTo(other._distance);

    double get inMeters => _distance;
}