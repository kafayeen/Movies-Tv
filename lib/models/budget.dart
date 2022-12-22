class Budget {
  late dynamic budget;
  Budget.fromJson(Map<String, dynamic> json) {
    budget = json["budget"];
  }
}
