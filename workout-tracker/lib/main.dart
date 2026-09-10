// Started with https://docs.flutter.dev/development/ui/widgets-intro
// update some of the imports for new file names
import 'package:flutter/material.dart';
import 'package:workout_tracker/objects/exercise.dart';
import 'package:workout_tracker/widgets/to_do_items.dart';
import 'package:workout_tracker/widgets/to_do_dialog.dart';

// swap out the old list stuff for new WorkoutList/WorkoutTracker stuff
class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State createState() => _WorkoutListState();
}

// Stateful widgets always are paried with a state smth
// type stf for stateful
// type st for stateless
class _WorkoutListState extends State<WorkoutList> {
  final List<Exercise> items = [Exercise(name: "Push-ups", muscleGroup: MuscleGroup.chest)];
  
  final _itemSet = <Exercise>{};

  void _handleListChanged(Exercise item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Exercise item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, MuscleGroup targetMuscle, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      // switch this from itemName to itemText 
      // drop const bc we dont need it
      Exercise item = Exercise(name: itemText, muscleGroup: targetMuscle);
      items.insert(0, item);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return ToDoListItem(
              item: item,
              completed: _itemSet.contains(item),
              onListChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Workout Tracker',
    home: WorkoutList(),
  ));
}
