import 'package:flutter/material.dart';
import 'package:workout_tracker/objects/exercise.dart';

typedef ExerciseRemovedCallback = Function(Exercise exercise);

class ExerciseListItem extends StatefulWidget {
  ExerciseListItem(
      {required this.exercise,
      required this.onDeleteExercise})
      : super(key: ObjectKey(exercise));

      @override
      State createState() => _ExerciseListItemState();

  final Exercise exercise;
  
  final ExerciseRemovedCallback onDeleteExercise;
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          widget.exercise.increment();
        });
      },
      onLongPress: () {
              widget.onDeleteExercise(widget.exercise);
            },
      leading: CircleAvatar(
        child: Text(widget.exercise.abbrev()),
      ),
      trailing: Text(
        widget.exercise.reps.toString()
      ),
      title: Text(
        widget.exercise.name,
      ),
    );
  }
}
