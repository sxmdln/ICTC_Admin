class Sale {
  int id;
  String firstName, middleName, lastName;
  String schedule;
  int totalStudents;
  int saleTotal;
  int discountTotal;

  Sale(
    {
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.schedule,
      required this.totalStudents,
      required this.saleTotal,
      required this.discountTotal,
    }
  );

  @override
  String toString() {
    return "$firstName $lastName";
  }
}