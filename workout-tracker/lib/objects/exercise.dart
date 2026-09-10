// enum for the potential muscle groups
enum MuscleGroup { chest, back, legs, arms, core, shoulders }

// rename from item to exercise and also require a muscle group enum
class Exercise {
  Exercise({required this.name, required this.muscleGroup});

  // final name and muscle group bc that wont change
  // reps start at zero bc you haven't done any, but that will change
  final String name;
  final MuscleGroup muscleGroup;
  int reps = 0;

  // rep counter
  void increment() {
    reps++;
  }

  // we still need this
  String abbrev() {
    return name.substring(0, 1);
  }
}