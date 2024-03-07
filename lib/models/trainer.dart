class Trainer {
  int id;
  String firstName, middleName, lastName;
  String emailAddress;
  String contactNumber;

  Trainer(
    {
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.emailAddress,
      required this.contactNumber,
    }
  );

  @override
  String toString() {
    return "$firstName $lastName";
  }
}