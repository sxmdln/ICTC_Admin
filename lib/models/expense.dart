class Expense {
  int id;
  String particulars;
  String programName;
  String courseName;
  DateTime orDate;
  String orNumber;
  int amount;

  Expense({
    required this.id,
    required this.particulars,
    required this.programName,
    required this.courseName,
    required this.orDate,
    required this.orNumber,
    required this.amount,
  });
}
