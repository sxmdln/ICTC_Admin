import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/report.dart';
import 'package:ictc_admin/models/payment.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:ictc_admin/models/trainer.dart';

class Seeds {
  static final List<Trainer> _trainers = [
    Trainer(
        id: 1,
        firstName: "John",
        middleName: "Ignatius",
        lastName: "Doe",
        email: "joidoe@exam.ple",
        contactNumber: "09123456789"),
    Trainer(
        id: 2,
        firstName: "Jane",
        middleName: "Ignatius",
        lastName: "Doe",
        email: "jaidoe@exam.ple",
        contactNumber: "09123456789"),
    Trainer(
        id: 3,
        firstName: "Jiggy",
        middleName: "Ignatius",
        lastName: "Bayola",
        email: "jibayola@exam.ple",
        contactNumber: "09123456789"),
  ];

  static final List<Trainee> _trainees = [
    Trainee(
      id: 202010824,
      firstName: "Samantha",
      middleName: "Largo",
      lastName: "De Las Nieves",
      email: "sdelasnieves@gbox.adnu.edu.ph",
      contactNumber: "09123456789",
    ),
    Trainee(
      id: 202010825,
      firstName: "Aaron",
      middleName: "Mangurali",
      lastName: "Serrano",
      email: "aaserrano@gbox.adnu.edu.ph",
      contactNumber: "09123456789",
    ),
  ];

  static final List<Course> _courses = [
    Course(
      id: 1,
      programId: -1,
      trainerId: -1,
      title: 'Hacking Course',
      description: 'Lorem ipsum please enroll now',
      cost: 20,
      duration: '2 hours',
      schedule: 'Jan 2',
      venue: 'Xavier Hall',
    ),
  ];

  static final List<Program> _programs = [
    Program(
      id: 1,
      title: 'Microcredential Program',
      description: 'Lorem ipsum please enroll now',
    ),
  ];

  static final List<Payment> _payments = [
    Payment(
      id: 1,
      studentId: _trainees[0].id,
      programId: _programs[0].id!,
      courseId: _courses[0].id!,
      discount: 250,
      orDate: DateTime.utc(2024, 4, 1),
      orNumber: 'OR2312312',
      totalAmount: 2250.0,
      approved: true,
    ),
  ];

  static final List<Expense> _expenses = [
    Expense(
      id: 1,
      particulars: 'Foodpanda Snacks',
      programId: _programs[0].id!,
      courseId: _courses[0].id!,
      orNumber: 'FOODPANDA1234',
      orDate: DateTime.utc(2024, 4, 1),
      amount: 1000,
    )
  ];

  static final List<Report> _reports = [
    Report(
      id: 1,
      date: 'December',
      totalIncome: 16,
      totalExpense: 6,
      netIncome: 10,
    ),
  ];

  static Stream<List<Trainer>> trainerStream() {
    return Stream.value(_trainers);
  }

  static Stream<List<Payment>> paymentStream() {
    return Stream.value(_payments);
  }

  static Stream<List<Expense>> expenseStream() {
    return Stream.value(_expenses);
  }

  static Stream<List<Course>> courseStream() {
    return Stream.value(_courses);
  }

  static Stream<List<Report>> reportStream() {
    return Stream.value(_reports);
  }
}
