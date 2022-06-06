extension DoublePrice on double {
  double toPrice() {
    return double.parse(toStringAsFixed(2));
  }
}
