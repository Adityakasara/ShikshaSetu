class Student {
  final String id;
  final String name;
  final String className;
  final double attendance; // in %
  final List<int> scores; // recent test scores
  final bool feesPaid;
  final double riskPercent; // ML predicted risk (0-100)

  Student({
    required this.id,
    required this.name,
    required this.className,
    required this.attendance,
    required this.scores,
    required this.feesPaid,
    required this.riskPercent,
  });

  // Get a quick risk label based on riskPercent
  String get riskLabel {
    if (riskPercent >= 70) return "High Risk";
    if (riskPercent >= 40) return "Warning";
    return "Safe";
  }
}
