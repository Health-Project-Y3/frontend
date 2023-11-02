import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thurula/models/user_weight_model.dart';
import 'package:thurula/services/user_weight_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thurula/views/pregnancy/add_weight.dart';

import '../../providers/user_provider.dart';

class ViewWeightPage extends StatefulWidget {
 // Make userId nullable in the constructor

  @override
  _ViewWeightPageState createState() => _ViewWeightPageState();
}

class _ViewWeightPageState extends State<ViewWeightPage> {
  List<UserWeight> userWeights = [];

  @override
  void initState() {
    var userId= context.read<UserProvider>().user?.id ?? '';
    super.initState();
    UserWeightService.getUserWeights(userId, null, null).then((weights) {
      setState(() {
        userWeights = weights;
        userWeights.sort((a, b) => b.date!.compareTo(a.date!));
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Weight Records'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use a different icon if desired
          onPressed: () {
            // Add navigation logic to go to the "Mother Health Tracker" page
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WeightMonitorPage()), // Replace with your actual page widget
            );
          },
        ),
      ),
      body: userWeights.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Weight Records',
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
              'Your weight records will be \n shown here once you enter them',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center, // Center-align the text
            )
          ],
        ),
      )
          : ListView.builder(
        itemCount: userWeights.length,
        itemBuilder: (context, index) {
          final currentWeight = userWeights[index];
          final currentMonth = currentWeight.date?.month;

          if (index == 0 || currentMonth != userWeights[index - 1].date?.month) {
            final monthYearText = DateFormat('MMMM yyyy').format(currentWeight.date!);
            return Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 220, 104, 145),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          monthYearText,
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
                buildWeightCard(currentWeight),
              ],
            );
          } else {
            return buildWeightCard(currentWeight);
          }
        },
      ),
    );
  }

  void _showEditDialog(UserWeight userWeight) {
    showDialog(
      context: context,
      builder: (context) {
        return EditWeightDialog(
          userWeight: userWeight,
          onEdit: _updateWeight,
          onDelete: () {
            showDeleteConfirmationDialog(userWeight);
          },
        );
      },
    );
  }

  Future<void> showDeleteConfirmationDialog(UserWeight userWeight) async {
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
      _deleteWeight(userWeight);
    }
  }

  void _updateWeight(UserWeight userWeight, double updatedWeight, DateTime updatedDate) async {
    UserWeight updatedUserWeight = UserWeight(
      id: userWeight.id,
      userId: userWeight.userId,
      weight: updatedWeight,
      date: updatedDate,
    );

    try {
      await UserWeightService.updateUserWeight(userWeight.id!, updatedUserWeight);

      int index = userWeights.indexWhere((element) => element.id == userWeight.id);
      if (index != -1) {
        setState(() {
          userWeights[index] = updatedUserWeight;
        });
      }

      Fluttertoast.showToast(msg: 'Updated successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Update failed: $e');
    }
  }

  void _deleteWeight(UserWeight userWeight) async {
    try {
      await UserWeightService.deleteUserWeight(userWeight.id!);

      setState(() {
        userWeights.removeWhere((element) => element.id == userWeight.id);
      });

      Fluttertoast.showToast(msg: 'Delete successful');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Delete failed: $e');
    }
  }

  Widget buildWeightCard(UserWeight weight) {
    return Card(
      child: ListTile(
        title: Text('Weight: ${weight.weight.toString()}'),
        subtitle: Text('Date: ${DateFormat('yyyy-MM-dd').format(weight.date ?? DateTime.now())}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(weight);
              },
              color: Color.fromARGB(255, 88, 119, 161),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDeleteConfirmationDialog(weight);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class EditWeightDialog extends StatefulWidget {
  final UserWeight userWeight;
  final Function(UserWeight, double, DateTime) onEdit;
  final VoidCallback onDelete;

  EditWeightDialog({required this.userWeight, required this.onEdit, required this.onDelete});

  @override
  _EditWeightDialogState createState() => _EditWeightDialogState();
}

class _EditWeightDialogState extends State<EditWeightDialog> {
  double? _updatedWeight;
  DateTime? _updatedDate;

  @override
  void initState() {
    super.initState();
    _updatedWeight = widget.userWeight.weight;
    _updatedDate = widget.userWeight.date;
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
                'Edit Weight Record',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Weight (kg/lbs)'),
              initialValue: _updatedWeight.toString(),
              onChanged: (value) {
                setState(() {
                  _updatedWeight = double.tryParse(value);
                });
              },
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
                widget.onEdit(widget.userWeight, _updatedWeight ?? 0.0, _updatedDate ?? DateTime.now());
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
