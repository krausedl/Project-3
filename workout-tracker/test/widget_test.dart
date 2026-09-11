// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workout_tracker/main.dart';
import 'package:workout_tracker/objects/exercise.dart';
import 'package:workout_tracker/widgets/exercise_list_item.dart';

void main() {
  test('Exercise abbreviation is first letter', () {
    Exercise exercise = Exercise(name: "add more exercises", muscleGroup: MuscleGroup.chest,);
    expect(exercise.abbrev(), "a");
  });
  // changed this text to work for exercises

  // doesnt follow naming convention because we shouldnt used the phrase "should be"
  // change the name to smth like 'Item abbreviation is first letter'


  test('Reps increment increases reps by 1', () {
    Exercise exercise = Exercise(name: "Push-ups", muscleGroup: MuscleGroup.chest);
    exercise.increment();
    expect(exercise.reps, 1);
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ExerciseListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ExerciseListItem(
                exercise: Exercise(name: "test", muscleGroup: MuscleGroup.back),
                onDeleteExercise: (Exercise exercise) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('tapping increments reps', 
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ExerciseListItem(
          exercise: Exercise(name: "test", muscleGroup: MuscleGroup.back),
          onDeleteExercise: (Exercise exercise) {}
      ))));
      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byType(ListTile));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
  });

  
  testWidgets('ExerciseListItem has a Circle Avatar with abbreviation',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ExerciseListItem(
              exercise: Exercise(name: "test", muscleGroup: MuscleGroup.back),
              onDeleteExercise: (Exercise exercise) {}))));
    final abbvFinder = find.text('t');
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(abbvFinder, findsOneWidget);
    expect(ctext.data, "t");
  });

  testWidgets('Default ExerciseList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WorkoutList()));

    final listExerciseFinder = find.byType(ExerciseListItem);

    expect(listExerciseFinder, findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to WorkoutList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: WorkoutList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    final listItemFinder = find.byType(ExerciseListItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  // One to test the tap and press actions on the items?
}
