import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thurula/models/user_bp_model.dart';
import 'package:thurula/services/user_bp_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers/user_provider.dart';

class ViewBloodPressurePage extends StatefulWidget {

  @override
  _ViewBloodPressurePageState createState() => _ViewBloodPressurePageState();
}

class _ViewBloodPressurePageState extends State<ViewBloodPressurePage> {
  List<UserBp> userBps = [];

  @override
  void initState() {
    var userId= context.read<UserProvider>().user?.id ?? '';
    super.initState();
    UserBpService.getUserBps(userId, null, null).then((bps) {
      setState(() {
        userBps = bps;
        userBps.sort((a, b) => b.date!.compareTo(a.date!));
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Blood Pressure Records'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use a different icon if desired
          onPressed: () {
            // Add navigation logic to go to the previous page
            Navigator.of(context).pop();
          },
        ),
      ),
      body: userBps.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Blood Pressure Records',
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
              'Your blood pressure records will be \n shown here once you enter them',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center, // Center-align the text
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: userBps.length,
        itemBuilder: (context, index) {
          final currentBp = userBps[index];
          final currentMonth = currentBp.date?.month;

          if (index == 0 || currentMonth != userBps[index - 1].date?.month) {
            final monthYearText = DateFormat('MMMM yyyy').format(currentBp.date!);
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
                buildBloodPressureCard(currentBp),
              ],
            );
          } else {
            return buildBloodPressureCard(currentBp);
          }
        },
      ),
    );
  }

  void _showEditDialog(UserBp userBp) {
    showDialog(
      context: context,
      builder: (context) {
        return EditBloodPressureDialog(
          userBp: userBp,
          onEdit: _updateBloodPressure,
          onDelete: () {
            showDeleteConfirmationDialog(userBp);
          },
        );
      },
    );
  }

  Future<void> showDeleteConfirmationDialog(UserBp userBp) async {
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
      _deleteBloodPressure(userBp);
    }
  }

  void _updateBloodPressure(UserBp userBp, String updatedBp, DateTime updatedDate) async {
    UserBp updatedUserBp = UserBp(
      id: userBp.id,
      userId: userBp.userId,
      bloodPressure: updatedBp,
      date: updatedDate,
    );

    try {
      await UserBpService.updateUserBp(userBp.id!, updatedUserBp);

      int index = userBps.indexWhere((element) => element.id == userBp.id);
      if (index != -1) {
        setState(() {
          userBps[index] = updatedUserBp;
        });
      }

      Fluttertoast.showToast(msg: 'Updated successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Update failed: $e');
    }
  }

  void _deleteBloodPressure(UserBp userBp) async {
    try {
      await UserBpService.deleteUserBp(userBp.id!);

      setState(() {
        userBps.removeWhere((element) => element.id == userBp.id);
      });

      Fluttertoast.showToast(msg: 'Delete successful');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Delete failed: $e');
    }
  }



  Widget buildBloodPressureCard(UserBp bp) {
    return Card(
      child: ListTile(
        title: Text('Blood Pressure: ${bp.bloodPressure.toString()}'),
        subtitle: Text('Date: ${DateFormat('yyyy-MM-dd').format(bp.date ?? DateTime.now())}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(bp);
              },
              color: Color.fromARGB(255, 88, 119, 161),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDeleteConfirmationDialog(bp);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class EditBloodPressureDialog extends StatefulWidget {
  final UserBp userBp;
  final Function(UserBp, String, DateTime) onEdit;
  final VoidCallback onDelete;

  EditBloodPressureDialog({required this.userBp, required this.onEdit, required this.onDelete});

  @override
  _EditBloodPressureDialogState createState() => _EditBloodPressureDialogState();
}

class _EditBloodPressureDialogState extends State<EditBloodPressureDialog> {
  String? _updatedBp;
  DateTime? _updatedDate;

  @override
  void initState() {
    super.initState();
    _updatedBp = widget.userBp.bloodPressure;
    _updatedDate = widget.userBp.date;
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
                'Edit Blood Pressure Record',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Blood Pressure (mmHg)'),
              initialValue: _updatedBp.toString(),
              onChanged: (value) {
                setState(() {
                  _updatedBp = value;
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
                widget.onEdit(widget.userBp, _updatedBp ?? '', _updatedDate ?? DateTime.now());
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
