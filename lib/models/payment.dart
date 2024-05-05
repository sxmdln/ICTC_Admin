class Payment {
  int id;
  String firstName, middleName, lastName;
  String programName;
  String courseName;
  int trainingFee;
  int discount;
  DateTime orDate;
  String orNumber;
  int amount;
  bool isApproved;


  Payment(
    {
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.programName,
      required this.courseName,
      required this.trainingFee,
      required this.discount,
      required this.orDate,
      required this.orNumber,
      required this.amount,
      required this.isApproved,
    }
  );

  @override
  String toString() {
    return "$firstName $lastName";
  }
}