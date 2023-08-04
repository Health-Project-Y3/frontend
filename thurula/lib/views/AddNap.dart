import 'package:flutter/material.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/naps_service.dart';
import 'package:thurula/views/NapDetails.dart';

import '../models/naptimes_model.dart';



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

  void addNapData(){
    //create combined datetime object using data
    var startTime = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedStartTime!.hour, _selectedStartTime!.minute);
    var endTime = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day, _selectedEndTime!.hour, _selectedEndTime!.minute);
    LocalService.getCurrentBabyId().then(
        (id)=>{
          NapService.createNap(
            NapTimes(
              babyId: id,
              startTime: startTime,
              endTime: endTime,
              sleepNotes: "Went to sleep at ${_selectedStartTime!.hour}:${_selectedStartTime!.minute} and woke up at ${_selectedEndTime!.hour}:${_selectedEndTime!.minute}"
            ),
          )
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Baby Nap Details'),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            const SizedBox(height: 16),
            // Calendar component
            TextFormField(
              readOnly: true,
              onTap: _showDatePicker,
              decoration: const InputDecoration(
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

            const SizedBox(height: 16),
            // Time selection for starting nap
            TimeSelectionClock(
              label: 'Start Time',
              selectedTime: _selectedStartTime,
              onTap: () => _showTimePicker('start'),
            ),

            const SizedBox(height: 16),
            // Time selection for ending nap
            TimeSelectionClock(
              label: 'End Time',
              selectedTime: _selectedEndTime,
              onTap: () => _showTimePicker('end'),
            ),

            const SizedBox(height: 16),
            // Display number of hours baby slept
            TextFormField(
              readOnly: true,
              decoration: const InputDecoration(
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

            const SizedBox(height: 16),
            // Button,add nap details
            Center(
              child: ElevatedButton(
                onPressed: addNapData,
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 220, 104, 145)),
                child: const Text('Add Nap'),
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
