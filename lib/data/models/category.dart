/// Category model for filter selection
///
class Category {
  final String? name;
  final int? rateValue;
  bool? activeState;

  Category({
    this.name,
    this.rateValue,
    this.activeState = false,
  });
}
