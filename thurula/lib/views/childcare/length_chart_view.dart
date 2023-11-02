import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/baby_length_service.dart';
import 'package:thurula/views/custom_loading_indicator.dart';
import 'package:thurula/views/widgets/graphs/baby_length_chart_widget.dart';
import '../../providers/baby_provider.dart';
import '../widgets/graphs/point_widget.dart';

int lengthAddedMonths = 0;

class LengthChartView extends StatefulWidget {
  const LengthChartView({Key? key}) : super(key: key);

  @override
  State<LengthChartView> createState() => _LengthChartViewState();
}

Future<List<List<Point>>> loadData(gender, {id = ""}) async {
  List<List<Point>> allDataLists = [];

  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 10));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 25));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 50));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 75));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 90));

  if (id != "") {
    final babyData = await BabyLengthService().getBabyLength(id);
    final modifiedBabyData = babyData
        .where((point) => point.y != -1.0) // Filter out points with y = -1.0
        .toList();

    allDataLists.add(modifiedBabyData);
    lengthAddedMonths = modifiedBabyData.length;
  }

  return allDataLists;
}

// Define ValueNotifier here
ValueNotifier<int> refreshCounter = ValueNotifier<int>(0);

class _LengthChartViewState extends State<LengthChartView> {
  @override
  Widget build(BuildContext context) {
    final babyid = context.read<BabyProvider>().baby!.id!;
    final babygender = context.read<BabyProvider>().baby!.gender;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 10),
              child: Row(children: [
                const Text(
                  'Length Chart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 25),
                GestureDetector(
                  onTap: () {
                    showAdd(context);
                  },
                  child: const Icon(
                    Icons.add_circle,
                    color: Color.fromARGB(255, 220, 104, 145),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    showUpdate(context);
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color.fromARGB(255, 220, 104, 145),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    showDelete(context);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 220, 104, 145),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Row(
                children: [
                  const SizedBox(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Length (cm)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SizedBox(
                            width: 400,
                            height: 500,
                            child: ValueListenableBuilder<int>(
                              valueListenable: refreshCounter,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return FutureBuilder(
                                  future: loadData(babygender, id: babyid),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: BabyLengthChartWidget(
                                            snapshot.data),
                                      );
                                    } else {
                                      return CustomLoadingIndicator();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Text('Age (months)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Percentiles:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(width: 10),
                Container(
                  width: 10,
                  height: 10,
                  color: const Color.fromARGB(206, 185, 2, 2),
                ),
                const SizedBox(width: 5), // Spacer
                const Text('3rd & 97th'), // Text description for the chart data
                const SizedBox(width: 20), // Spacer
                Container(
                  width: 10,
                  height: 10,
                  color: const Color.fromARGB(255, 185, 157, 2),
                ),
                const SizedBox(width: 5),
                const Text('15th & 85th'),
                const SizedBox(width: 20),
                Container(
                  width: 10,
                  height: 10,
                  color: const Color.fromARGB(254, 14, 185, 2),
                ),
                const SizedBox(width: 5),
                const Text('50th'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Add Reading
class AddReadingDialog extends StatefulWidget {
  const AddReadingDialog({super.key});

  @override
  _AddReadingDialogState createState() => _AddReadingDialogState();
}

class _AddReadingDialogState extends State<AddReadingDialog> {
  int selectedMonth = lengthAddedMonths; // Default selected month
  double? length; // Variable to store the entered length
  String? lengthError; // Error message for invalid length

  TextEditingController lengthController =
      TextEditingController(); // Define the controller

  @override
  Widget build(BuildContext context) {
    final babyid = context.read<BabyProvider>().baby!.id!;

    return AlertDialog(
      title: const Text('Add New Reading'),
      contentPadding:
          const EdgeInsets.fromLTRB(20, 20, 20, 0), // Adjust padding as needed
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: selectedMonth,
            onChanged: (int? newValue) {
              setState(() {
                selectedMonth = newValue!;
              });
            },
            items: List.generate(
              25 - lengthAddedMonths,
              (index) => DropdownMenuItem<int>(
                value: index + lengthAddedMonths,
                child: Text('Month ${index + lengthAddedMonths}'),
              ),
            ),
          ),
          const SizedBox(height: 10), // Adjust the height as needed
          TextField(
            controller: lengthController, // Use the defined controller
            decoration: InputDecoration(
              labelText: 'Length (cm)',
              errorText: lengthError, // Set the error text here
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Parse the value to a double and store it in the length variable
              length = double.tryParse(value);
              // Clear the error when the user makes changes
              setState(() {
                lengthError = null;
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            double? enteredLength = double.tryParse(lengthController.text);
            if (_validateLength(enteredLength)) {
              BabyLengthService()
                  .addBabyLength(babyid, selectedMonth, enteredLength!);
              Navigator.of(context).pop(); // Close the dialog
              refreshCounter.value++; // Trigger UI update
            } else {
              setState(() {
                lengthError = 'Length must be between 40 and 150 cm.';
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 119, 161),
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}

void showAdd(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddReadingDialog(); // Use the Stateful dialog
    },
  );
}

// Update Reading
class UpdateReadingDialog extends StatefulWidget {
  const UpdateReadingDialog({super.key});

  @override
  _UpdateReadingDialogState createState() => _UpdateReadingDialogState();
}

class _UpdateReadingDialogState extends State<UpdateReadingDialog> {
  int selectedMonth = 0; // Default selected month
  double? length; // Variable to store the entered length
  String? lengthError; // Error message for invalid length

  TextEditingController lengthController =
      TextEditingController(); // Define the controller

  @override
  Widget build(BuildContext context) {
    final babyid = context.read<BabyProvider>().baby!.id!;
    return AlertDialog(
      title: const Text('Update Reading'),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: selectedMonth,
            onChanged: (int? newValue) {
              setState(() {
                selectedMonth = newValue!;
              });
            },
            items: List.generate(
              lengthAddedMonths - 1,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: Text('Month ${index + 1}'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: lengthController, // Use the defined controller
            decoration: InputDecoration(
              labelText: 'Length (cm)',
              errorText: lengthError, // Set the error text here
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Parse the value to a double and store it in the length variable
              length = double.tryParse(value);
              // Clear the error when the user makes changes
              setState(() {
                lengthError = null;
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            double? enteredLength = double.tryParse(lengthController.text);
            if (_validateLength(enteredLength)) {
              BabyLengthService()
                  .editBabyLength(babyid, selectedMonth + 1, enteredLength!);
              Navigator.of(context).pop(); // Close the dialog
              refreshCounter.value++; // Trigger UI update
            } else {
              setState(() {
                lengthError = 'Length must be between 40 and 150 cm.';
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 119, 161),
          ),
          child: const Text('Update'),
        ),
      ],
    );
  }
}

void showUpdate(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const UpdateReadingDialog(); // Use the Stateful dialog
    },
  );
}

bool _validateLength(double? length) {
  return length != null && length >= 40 && length <= 150;
}

// Delete latest reading
class DeleteReadingDialog extends StatefulWidget {
  const DeleteReadingDialog({super.key});

  @override
  _DeleteReadingDialogState createState() => _DeleteReadingDialogState();
}

class _DeleteReadingDialogState extends State<DeleteReadingDialog> {
  int selectedMonth = lengthAddedMonths - 1; // Default selected month

  @override
  Widget build(BuildContext context) {
    final babyid = context.read<BabyProvider>().baby!.id!;

    return AlertDialog(
      title: const Text('Delete Latest Reading'),
      contentPadding:
          const EdgeInsets.fromLTRB(20, 20, 20, 0), // Adjust padding as needed
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Month',
            ),
            enabled: false,
            controller: TextEditingController(text: 'Month $selectedMonth'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            BabyLengthService().deleteBabyLength(babyid, selectedMonth);
            Navigator.of(context).pop(); // Close the dialog
            refreshCounter.value++; // Trigger UI update
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 119, 161),
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

void showDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DeleteReadingDialog(); // Use the Stateful dialog
    },
  );
}
