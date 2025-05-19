// lib/logic/workout_generator.dart

List<String> generateWorkoutPlan(Map<String, dynamic> userData) {
  final String gender = userData['gender'];
  final int age = userData['age'];
  final double height = userData['height'];
  final double weight = userData['weight'];
  final String goal = userData['goal'];

  List<String> plan = [];

  if (goal == 'kilo vermek') {
    plan.add("Koşu (30 dk)");
    plan.add("HIIT (20 dk)");
    if (age < 30) {
      plan.add("Squat (3x15)");
    }
    if (weight > 80) {
      plan.add("Yüksek tempolu yürüyüş (45 dk)");
    }
  }

  if (goal == 'kilo almak') {
    plan.add("Ağırlık antrenmanı: Göğüs, Omuz");
    if (weight < 65) {
      plan.add("Leg Press (3x12)");
      plan.add("Deadlift (3x10)");
    } else {
      plan.add("Bench Press (3x8)");
    }
  }

  if (goal == 'formda kalmak') {
    plan.add("Yoga (30 dk)");
    plan.add("Koşu (20 dk)");
    if (age > 40) {
      plan.add("Pilates");
    }
  }

  if (gender == "kadın") {
    plan.add("Glute Bridge (3x15)");
  } else {
    plan.add("Push-up (3x20)");
  }

  return plan;
}
