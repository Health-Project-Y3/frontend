import 'package:flutter/material.dart';
import 'package:thurula/services/baby_weight_service.dart';
import 'package:thurula/views/widgets/graphs/baby_weight_chart_widget.dart';
import '../widgets/graphs/point_widget.dart';

int weightAddedMonths = 0;

//Todo: Add baby ID  and gender function
const babyid = "64a9cb10ec5c9834ff73fc36";
const babygender = "male";

class WeightChartView extends StatefulWidget {
  const WeightChartView({Key? key}) : super(key: key);

  @override
  State<WeightChartView> createState() => _WeightChartView();
}

Future<List<List<Point>>> loadData(gender, {id = ""}) async {
  List<List<Point>> allDataLists = [];

  allDataLists.add(await BabyWeightService().getReferenceWeight(gender, 10));
  allDataLists.add(await BabyWeightService().getReferenceWeight(gender, 25));
  allDataLists.add(await BabyWeightService().getReferenceWeight(gender, 50));
  allDataLists.add(await BabyWeightService().getReferenceWeight(gender, 75));
  allDataLists.add(await BabyWeightService().getReferenceWeight(gender, 90));

  if (id != "") {
    final babyData = await BabyWeightService().getBabyWeight(id);
    final modifiedBabyData = babyData
        .where((point) => point.y != -1.0) // Filter out points with y = -1.0
        .toList();

    allDataLists.add(modifiedBabyData);
    weightAddedMonths = modifiedBabyData.length;
  }

  return allDataLists;
}

// Define ValueNotifier here
ValueNotifier<int> refreshCounter = ValueNotifier<int>(0);

class _WeightChartView extends State<WeightChartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 10),
              child: Row(children: [
                const Text(
                  'Weight Chart',
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
                          'Weight (kg)',
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
                                        child: BabyWeightChartWidget(
                                            snapshot.data),
                                      );
                                    } else {
                                      return const SizedBox(
                                        height: 10.0,
                                        width: 10.0,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Color.fromARGB(
                                                255, 220, 104, 145),
                                          ),
                                        ),
                                      );
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
  int selectedMonth = weightAddedMonths; // Default selected month
  double? weight; // Variable to store the entered weight
  String? weightError; // Error message for invalid weight

  TextEditingController weightController =
      TextEditingController(); // Define the controller

  @override
  Widget build(BuildContext context) {
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
              25 - weightAddedMonths,
              (index) => DropdownMenuItem<int>(
                value: index + weightAddedMonths,
                child: Text('Month ${index + weightAddedMonths}'),
              ),
            ),
          ),
          const SizedBox(height: 10), // Adjust the height as needed
          TextField(
            controller: weightController, // Use the defined controller
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              errorText: weightError, // Set the error text here
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Parse the value to a double and store it in the weight variable
              weight = double.tryParse(value);
              // Clear the error when the user makes changes
              setState(() {
                weightError = null;
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
            double? enteredWeight = double.tryParse(weightController.text);
            if (_validateWeight(enteredWeight)) {
              BabyWeightService()
                  .addBabyWeight(babyid, selectedMonth, enteredWeight!);
              Navigator.of(context).pop(); // Close the dialog
              refreshCounter.value++; // Trigger UI update
            } else {
              setState(() {
                weightError = 'Weight must be between 1 and 15 kg.';
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
  double? weight; // Variable to store the entered Weight
  String? weightError; // Error message for invalid Weight

  TextEditingController weightController =
      TextEditingController(); // Define the controller

  @override
  Widget build(BuildContext context) {
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
              weightAddedMonths - 1,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: Text('Month ${index + 1}'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: weightController, // Use the defined controller
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              errorText: weightError, // Set the error text here
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Parse the value to a double and store it in the Weight variable
              weight = double.tryParse(value);
              // Clear the error when the user makes changes
              setState(() {
                weightError = null;
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
            double? enteredWeight = double.tryParse(weightController.text);
            if (_validateWeight(enteredWeight)) {
              BabyWeightService()
                  .editBabyWeight(babyid, selectedMonth + 1, enteredWeight!);
              Navigator.of(context).pop(); // Close the dialog
              refreshCounter.value++; // Trigger UI update
            } else {
              setState(() {
                weightError = 'Weight must be between 1 and 15 kg.';
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

bool _validateWeight(double? weight) {
  return weight != null && weight >= 1 && weight <= 20;
}

// Delete latest reading
class DeleteReadingDialog extends StatefulWidget {
  const DeleteReadingDialog({super.key});

  @override
  _DeleteReadingDialogState createState() => _DeleteReadingDialogState();
}

class _DeleteReadingDialogState extends State<DeleteReadingDialog> {
  int selectedMonth = weightAddedMonths - 1; // Default selected month

  @override
  Widget build(BuildContext context) {
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
            BabyWeightService().deleteBabyWeight(babyid, selectedMonth);
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
