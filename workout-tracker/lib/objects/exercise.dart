// enum for the potential muscle groups
enum MuscleGroup { chest, back, legs, arms, core, shoulders }

// rename from item to exercise and also require a muscle group enum
class Exercise {
  Exercise({required this.name, required this.muscleGroup});

  // final name and muscle group bc that wont change
  // reps start at zero bc you haven't done any, but that will change
  final String name;
  final MuscleGroup muscleGroup;

  // reps cannot be const because they will end up incrementing
  int reps = 0;

  // rep counter
  // reps++ here rather than directly in the widget so that the date will actually change and also to help with tests
  // a method is easier to check? 
  void increment() {
    reps++;
  }

  // we still need this, also bc this didnt change, our test wont change
  String abbrev() {
    return name.substring(0, 1);
  }
}