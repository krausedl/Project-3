import 'package:flutter/material.dart';
import 'package:workout_tracker/objects/exercise.dart';

typedef ExerciseAddedCallback = Function(
    String value, MuscleGroup targetMuscle, TextEditingController textController);

class ExerciseDialog extends StatefulWidget {
  const ExerciseDialog({
    super.key,
    required this.onListAdded,
  });

  final ExerciseAddedCallback onListAdded;

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  MuscleGroup valueMuscle = MuscleGroup.chest;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exercise To Add'),
      content: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _inputController,
            decoration: const InputDecoration(hintText: "type exercise name here"),
          ),
          DropdownButton<MuscleGroup>(
            value: valueMuscle,
            items: MuscleGroup.values.map((group) {
              return DropdownMenuItem(
                value: group,
                child: Text(group.name),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                // update the targeted muscle
                valueMuscle = newValue!;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key('CancelButton'),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(valueText, valueMuscle, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}