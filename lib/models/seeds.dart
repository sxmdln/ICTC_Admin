import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/expense.dart';
import 'package:ictc_admin/models/finance.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/sale.dart';
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

  static final List<Income> _incomes = [
    Income(
      id: 1,
      firstName: 'Samantha',
      middleName: "Largo",
      lastName: "De Las Nieves",
      schedule: 'March 4, 2023',
      totalStudents: 4,
      incomeTotal: 2000,
      discountTotal: 200,
    ),
  ];

  static final List<Finance> _finances = [
    Finance(
      id: 1,
      date: 'March',
      detail: 'adasd',
      program: 'GCE',
      price: 1200,
      quantity: 2,
      total: 1,
    ),
    Finance(
      id: 2,
      date: 'December',
      detail: 'Ulol',
      program: 'Microcredentials',
      price: 4200,
      quantity: 3,
      total: 100,
    ),
  ];


  static final List<Expense> _expenses = [
    Expense(id: 1, name: 'Snacks', courseName: 'Microcredentials', date: 'March 4, 2023', cost: 1000)
  ];

  static Stream<List<Trainer>> trainerStream() {
    return Stream.value(_trainers);
  }

  static Stream<List<Income>> incomeStream() {
    return Stream.value(_incomes);
  }

  static Stream<List<Expense>> expenseStream() {
    return Stream.value(_expenses);
  }
  static Stream<List<Course>> courseStream() {
    return Stream.value(_courses);
  }
  static Stream<List<Finance>> financeStream() {
    return Stream.value(_finances);
  }
}
