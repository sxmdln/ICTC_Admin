class Income {
  int id;
  String firstName, middleName, lastName;
  String schedule;
  int totalStudents;
  int incomeTotal;
  int discountTotal;

  Income(
    {
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.schedule,
      required this.totalStudents,
      required this.incomeTotal,
      required this.discountTotal,
    }
  );

  @override
  String toString() {
    return "$firstName $lastName";
  }
}