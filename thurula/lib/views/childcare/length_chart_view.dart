import 'package:flutter/material.dart';
import 'package:thurula/services/baby_length_service.dart';
import 'package:thurula/views/widgets/graphs/baby_length_chart_widget.dart';
import '../widgets/graphs/point_widget.dart';

int lengthAddedMonths = 0;

const babyid = "64a9cb10ec5c9834ff73fc36";

class LengthChartView extends StatefulWidget {
  const LengthChartView({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Length Chart'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 10),
              child: Row(children: [
                const Text(
                  'Baby Growth Chart',
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
                const SizedBox(width: 25),
                GestureDetector(
                  onTap: () {
                    showUpdate(context);
                  },
                  child: const Icon(
                    Icons.edit_outlined,
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
                          style: TextStyle(fontSize: 16),
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
                                  future: loadData("male", id: babyid),
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
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text('Age (months)', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Reading
class AddReadingDialog extends StatefulWidget {
  @override
  _AddReadingDialogState createState() => _AddReadingDialogState();
}

class _AddReadingDialogState extends State<AddReadingDialog> {
  int selectedMonth = lengthAddedMonths; // Default selected month
  double? length; // Variable to store the entered length

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
              25 - lengthAddedMonths,
              (index) => DropdownMenuItem<int>(
                value: index + lengthAddedMonths,
                child: Text('Month ${index + lengthAddedMonths}'),
              ),
            ),
          ),
          const SizedBox(height: 10), // Adjust the height as needed
          TextField(
            decoration: const InputDecoration(labelText: 'Length (cm)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Parse the value to a double and store it in the length variable
              length = double.tryParse(value);
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
            if (length != null) {
              BabyLengthService().addBabyLength(babyid, selectedMonth, length!);
              Navigator.of(context).pop(); // Close the dialog
              refreshCounter.value++; // Trigger UI update
            } else {
              print("error");
            }
          },
          child: const Text('Add'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 119, 161),
          ),
        ),
      ],
    );
  }
}

void showAdd(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddReadingDialog(); // Use the Stateful dialog
    },
  );
}

// Update Reading
class UpdateReadingDialog extends StatefulWidget {
  @override
  _UpdatReadingDialogState createState() => _UpdatReadingDialogState();
}

class _UpdatReadingDialogState extends State<UpdateReadingDialog> {
  int selectedMonth = 0; // Default selected month
  double? length; // Variable to store the entered length

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
              lengthAddedMonths - 1,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: Text('Month ${index + 1}'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(labelText: 'Length (cm)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Parse the value to a double and store it in the length variable
              length = double.tryParse(value);
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
            if (length != null) {
              BabyLengthService()
                  .editBabyLength(babyid, selectedMonth + 1, length!);
              Navigator.of(context).pop(); // Close the dialog
              refreshCounter.value++; // Trigger UI update
            } else {
              print("error");
            }
          },
          child: const Text('Update'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 119, 161),
          ),
        ),
      ],
    );
  }
}

void showUpdate(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UpdateReadingDialog(); // Use the Stateful dialog
    },
  );
}
