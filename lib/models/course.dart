class Course {

  int id;
  String title;
  String description;
  int cost;
  String duration;
  String schedule;
  String venue;
  // add program id, trainer id (not required)


  Course(
    {
      required this.id,
      required this.title,
      required this.description,
      required this.cost,
      required this.duration,
      required this.schedule,
      required this.venue,
    }
  );
}