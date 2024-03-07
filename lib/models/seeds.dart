import 'package:ictc_admin/models/course.dart';
import 'package:ictc_admin/models/program.dart';
import 'package:ictc_admin/models/trainee.dart';
import 'package:ictc_admin/models/trainer.dart';

class Seeds {
  static List<Trainer> trainers = [
    Trainer(
        id: 1,
        firstName: "John",
        middleName: "Ignatius",
        lastName: "Doe",
        emailAddress: "joidoe@exam.ple",
        contactNumber: "09123456789"),
    Trainer(
        id: 2,
        firstName: "Jane",
        middleName: "Ignatius",
        lastName: "Doe",
        emailAddress: "jaidoe@exam.ple",
        contactNumber: "09123456789"),
    Trainer(
        id: 3,
        firstName: "Jiggy",
        middleName: "Ignatius",
        lastName: "Bayola",
        emailAddress: "jibayola@exam.ple",
        contactNumber: "09123456789"),
  ];

  static List<Trainee> trainees = [
    Trainee(
      id: 202010824,
      firstName: "Samantha",
      middleName: "Largo",
      lastName: "De Las Nieves",
      emailAddress: "sdelasnieves@gbox.adnu.edu.ph",
      contactNumber: "09123456789",
    ),
    Trainee(
      id: 202010825,
      firstName: "Aaron",
      middleName: "Mangurali",
      lastName: "Serrano",
      emailAddress: "aaserrano@gbox.adnu.edu.ph",
      contactNumber: "09123456789",
    ),
  ];

  static List<Course> courses = [
    Course(
      id: 1,
      title: 'Hacking Course',
      description: 'Lorem ipsum please enroll now',
      cost: 20,
      duration: '2 hours',
      schedule: 'Jan 2',
      venue: 'Xavier Hall',
    ),
  ];

  static List<Program> programs = [
    Program(
      id: 1,
      title: 'Microcredential Program',
      description: 'Lorem ipsum please enroll now',
    ),
  ];
}
