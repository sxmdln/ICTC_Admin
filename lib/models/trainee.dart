class Trainee {
  int id;
  String firstName, middleName, lastName;
  String emailAddress;
  String contactNumber;
  // String school;
  // String office;
  // String designation;
  // int yearLevel;

  Trainee(
    {
      required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.emailAddress,
      required this.contactNumber,
      // required this.school,
      // required this.office,
      // required this.designation,
      // required this.yearLevel,
    }
  );

  @override
  String toString() {
    return "$firstName $lastName";
  }

  // double totalTrainees(){
  //   double total = 0.0;
  //   for(Trainee trainee in Trainee){
  //     total += product.price * product.quantity;
  //   }
  //   return total;
  // }
}