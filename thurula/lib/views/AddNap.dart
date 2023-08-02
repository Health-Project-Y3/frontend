import 'package:flutter/material.dart';
import 'package:thurula/views/NapDetails.dart';



class AddNap extends StatefulWidget {
  @override
  _AddNapState createState() => _AddNapState();
}

class _AddNapState extends State<AddNap> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _showTimePicker(String type) async {
    TimeOfDay initialTime = TimeOfDay.now();
    if (type == 'start' && _selectedStartTime != null) {
      initialTime = _selectedStartTime!;
    } else if (type == 'end' && _selectedEndTime != null) {
      initialTime = _selectedEndTime!;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (type == 'start') {
          _selectedStartTime = pickedTime;
        } else if (type == 'end') {
          _selectedEndTime = pickedTime;
          // Calculate and update the difference in hours
          final diff = pickedTime.hour - _selectedStartTime!.hour +
              (pickedTime.minute - _selectedStartTime!.minute) / 60;
          _selectedEndTime = pickedTime;
          _selectedDate = DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedStartTime!.hour,
            _selectedStartTime!.minute,
          );
          _selectedDate = _selectedDate!.add(Duration(hours: diff.toInt(), minutes: (diff * 60).toInt() % 60));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Nap Timer'),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NapDetails()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            // Calendar component as a popup modal
            TextFormField(
              readOnly: true,
              onTap: _showDatePicker,
              decoration: InputDecoration(
                labelText: 'Date',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
              ),
              controller: TextEditingController(
                text: _selectedDate != null
                    ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                    : "",
              ),
            ),

            SizedBox(height: 16),
            // Time selection for starting nap
            TimeSelectionClock(
              label: 'Start Time',
              selectedTime: _selectedStartTime,
              onTap: () => _showTimePicker('start'),
            ),

            SizedBox(height: 16),
            // Time selection for ending nap
            TimeSelectionClock(
              label: 'End Time',
              selectedTime: _selectedEndTime,
              onTap: () => _showTimePicker('end'),
            ),

            SizedBox(height: 16),
            // Display number of hours baby slept
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Number of Hours Slept',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: Icon(Icons.access_time, color: Colors.black),
              ),
              controller: TextEditingController(
                text: _selectedEndTime != null && _selectedStartTime != null
                    ? "${(_selectedEndTime!.hour - _selectedStartTime!.hour).toString().padLeft(2, '0')}:${(_selectedEndTime!.minute - _selectedStartTime!.minute).toString().padLeft(2, '0')}"
                    : "",
              ),
            ),

            SizedBox(height: 16),
            // Button to add nap details
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement the action to add nap details
                },
                style: ElevatedButton.styleFrom(primary: Colors.pink),
                child: Text('Add Nap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSelectionClock extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final VoidCallback onTap;

  TimeSelectionClock({
    required this.label,
    required this.selectedTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: Icon(Icons.access_time, color: Colors.black),
          ),
          controller: TextEditingController(
            text: selectedTime != null
                ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                : "",
          ),
        ),
      ],
    );
  }
}
