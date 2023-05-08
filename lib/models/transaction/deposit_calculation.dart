class DepositCalculation {
  late int alreadyDeposited;
  late int notYetDeposited;

  DepositCalculation({
    required this.alreadyDeposited,
    required this.notYetDeposited,
  });

  DepositCalculation.fromJson(Map<String, dynamic> json) {
    alreadyDeposited = json['already_deposited'];
    notYetDeposited = json['not_yet_deposited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['already_deposited'] = alreadyDeposited;
    data['not_yet_deposited'] = notYetDeposited;
    return data;
  }
}
