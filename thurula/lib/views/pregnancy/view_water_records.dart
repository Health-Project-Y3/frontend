import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thurula/models/user_drinking_model.dart';
import 'package:thurula/services/user_drinking_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers/user_provider.dart';
import 'add_water.dart';

class ViewWaterPage extends StatefulWidget {


  @override
  _ViewWaterPageState createState() => _ViewWaterPageState();
}

class _ViewWaterPageState extends State<ViewWaterPage> {
  List<UserDrinking> userDrinkings = [];

  @override
  void initState() {
    var userId= context.read<UserProvider>().user?.id ?? '';
    super.initState();
    UserDrinkingService.getUserDrinkings(userId, null, null).then((drinkings) {
      setState(() {
        userDrinkings = drinkings;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<UserDrinking>> groupedDrinkings = groupDrinkingsByDay(userDrinkings);

    return Scaffold(
      appBar: AppBar(
        title: Text('View Water Records'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use a different icon if desired
          onPressed: () {
            // Add navigation logic to go to the "Mother Health Tracker" page
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WaterMonitorPage()), // Replace with your actual page widget
            );
          },
        ),
      ),
      body: groupedDrinkings.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Water Records',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '😢',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your water records will be shown here once you enter them',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
          : ListView.builder(
        itemCount: groupedDrinkings.length,
        itemBuilder: (context, index) {
          final day = groupedDrinkings.keys.elementAt(index);
          final drinkings = groupedDrinkings[day];

          return Column(
            children: [
              Container(
                color: Color.fromARGB(255, 220, 104, 145),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('MMMM dd, yyyy').format(day),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (var drinking in drinkings!)
                buildWaterCard(drinking),
            ],
          );
        },
      ),
    );
  }

  Map<DateTime, List<UserDrinking>> groupDrinkingsByDay(List<UserDrinking> drinkings) {
    Map<DateTime, List<UserDrinking>> groupedDrinkings = {};

    for (var drinking in drinkings) {
      final date = drinking.date;
      if (date != null) {
        final day = DateTime(date.year, date.month, date.day);
        if (!groupedDrinkings.containsKey(day)) {
          groupedDrinkings[day] = [];
        }
        groupedDrinkings[day]!.add(drinking);
      }
    }

    return groupedDrinkings;
  }

  Widget buildWaterCard(UserDrinking drinking) {
    return Card(
      child: ListTile(
        title: Text('Glasses Drunk: ${drinking.glassesDrunk.toString()}'),
        subtitle: Text('Date: ${DateFormat('yyyy-MM-dd').format(drinking.date ?? DateTime.now())}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(drinking);
              },
              color: Color.fromARGB(255, 88, 119, 161),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDeleteConfirmationDialog(drinking);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(UserDrinking drinking) {
    showDialog(
      context: context,
      builder: (context) {
        return EditWaterDialog(
          drinking: drinking,
          onEdit: _updateDrinking,
          onDelete: () {
            showDeleteConfirmationDialog(drinking);
          },
        );
      },
    );
  }

  Future<void> showDeleteConfirmationDialog(UserDrinking drinking) async {
    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this record?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (deleteConfirmed) {
      _deleteDrinking(drinking);
    }
  }

  void _updateDrinking(UserDrinking drinking, int updatedGlassesDrunk, DateTime updatedDate) async {
    UserDrinking updatedDrinking = UserDrinking(
      id: drinking.id,
      userId: drinking.userId,
      glassesDrunk: updatedGlassesDrunk,
      date: updatedDate,
    );

    try {
      await UserDrinkingService.updateUserDrinking(drinking.id!, updatedDrinking);

      int index = userDrinkings.indexWhere((element) => element.id == drinking.id);
      if (index != -1) {
        setState(() {
          userDrinkings[index] = updatedDrinking;
        });
      }

      Fluttertoast.showToast(msg: 'Updated successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Update failed: $e');
    }
  }

  void _deleteDrinking(UserDrinking drinking) async {
    try {
      await UserDrinkingService.deleteUserDrinking(drinking.id!);

      setState(() {
        userDrinkings.removeWhere((element) => element.id == drinking.id);
      });

      Fluttertoast.showToast(msg: 'Delete successful');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Delete failed: $e');
    }
  }
}

class EditWaterDialog extends StatefulWidget {
  final UserDrinking drinking;
  final Function(UserDrinking, int, DateTime) onEdit;
  final VoidCallback onDelete;

  EditWaterDialog({required this.drinking, required this.onEdit, required this.onDelete});

  @override
  _EditWaterDialogState createState() => _EditWaterDialogState();
}

class _EditWaterDialogState extends State<EditWaterDialog> {
  int? _updatedGlassesDrunk;
  DateTime? _updatedDate;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _updatedGlassesDrunk = widget.drinking.glassesDrunk;
    _updatedDate = widget.drinking.date;
    _selectedOption = '$_updatedGlassesDrunk';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Edit Water Record',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedOption,
              onChanged: (newValue) {
                setState(() {
                  _selectedOption = newValue;
                  _updatedGlassesDrunk = int.tryParse(newValue!);
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Option',
              ),
              items: [
                DropdownMenuItem<String>(
                  value: '1',
                  child: Text('1 Glass (240ml)'),
                ),
                DropdownMenuItem<String>(
                  value: '2',
                  child: Text('2 Glasses (480ml)'),
                ),
                DropdownMenuItem<String>(
                  value: '3',
                  child: Text('3 Glasses (720ml)'),
                ),
                DropdownMenuItem<String>(
                  value: '4',
                  child: Text('4 Glasses (960ml)'),
                ),
                DropdownMenuItem<String>(
                  value: '5',
                  child: Text('5 Glasses (1200ml)'),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date'),
              readOnly: true,
              controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(_updatedDate ?? DateTime.now())),
              onTap: () {
                _selectDate(context);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onEdit(widget.drinking, _updatedGlassesDrunk ?? 0, _updatedDate ?? DateTime.now());
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 220, 104, 145),
                minimumSize: Size(double.infinity, 0.0),
                padding: EdgeInsets.all(16.0),
              ),
              child: Text('Update'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _updatedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _updatedDate) {
      setState(() {
        _updatedDate = picked;
      });
    }
  }
}
