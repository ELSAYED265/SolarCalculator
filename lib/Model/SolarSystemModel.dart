class SolarSystemModel {
  /// Actual System Capacity (KWp)
  final double actualSystemCapacityKwp;

  /// Number of Panels
  final int numberOfPanels;

  /// Required Area (m²)
  final double requiredArea;

  /// Initial Cost
  final double initialCost;

  SolarSystemModel({
    required this.actualSystemCapacityKwp,
    required this.numberOfPanels,
    required this.requiredArea,
    required this.initialCost,
  });
}
