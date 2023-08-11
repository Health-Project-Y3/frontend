import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy_home_view.dart';

void main() {
  runApp(const BabyNames());
}

class BabyNames extends StatelessWidget {
  const BabyNames({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BabyNamePage(),
    );
  }
}

class BabyNamePage extends StatefulWidget {
  const BabyNamePage({super.key});

  @override
  _BabyNamePageState createState() => _BabyNamePageState();
}

class _BabyNamePageState extends State<BabyNamePage> {
  // Dummy list of baby names for girls and boys
  final List<BabyName> girlNames = [
    BabyName(name: 'Achala', meaning: 'steady'),
    BabyName(name: 'Asheni', meaning: 'a strict natured'),
    BabyName(name: 'Avanthi', meaning: 'a name of historical city'),
    BabyName(name: 'Ayomi', meaning: 'my joy'),
    BabyName(name: 'Bebi', meaning: 'baby'),
    BabyName(name: 'Bhakthi', meaning: 'devotion'),
    BabyName(name: 'Buddhika', meaning: 'clever and wise'),
    BabyName(name: 'Chandrika', meaning: 'moonlight; fair; cool'),
    BabyName(name: 'Chathura', meaning: 'skilful; smart'),
    BabyName(name: 'Chatura', meaning: 'clever; wise'),
    BabyName(name: 'Chithkala', meaning: 'knowledge'),
    BabyName(name: 'Dayani', meaning: 'friendly'),
    BabyName(name: 'Dulani', meaning: 'cutting'),
    BabyName(name: 'Eromi', meaning: 'sun; understanding'),
    BabyName(name: 'Gayesha', meaning: 'expressive'),
    BabyName(name: 'Harshani', meaning: 'joy; delight'),
    BabyName(name: 'Hashini', meaning: 'happiness; joyful'),
    BabyName(name: 'Hinni', meaning: 'God strengthens'),
    BabyName(name: 'Kusum', meaning: 'safe; happy'),
    BabyName(name: 'Isuri', meaning: 'lucky; fortunate'),
    BabyName(name: 'Lakmini', meaning: 'independent'),
    BabyName(name: 'Lakshani', meaning: 'nice with everyone'),
    BabyName(name: 'Lakshitha', meaning: 'she who is distinguished'),
    BabyName(name: 'Liyoni', meaning: 'the origin of writing'),
    BabyName(name: 'Lochani', meaning: 'she who has bright eyes'),
    BabyName(name: 'Mandari', meaning: 'the Coral tree'),
    BabyName(name: 'Manisha', meaning: 'wish; desire'),
    BabyName(name: 'Mihika', meaning: 'fog; mist; snow'),
    BabyName(name: 'Minrada', meaning: 'she who gives wisdom and love'),
    BabyName(name: 'Nadeeka', meaning: 'creative'),
    BabyName(name: 'Nadesha', meaning: 'born of a river'),
    BabyName(name: 'Nayanadini', meaning: 'she who has attractive eyes'),
    BabyName(name: 'Neja', meaning: 'success in law'),
    BabyName(name: 'Nevinka', meaning: 'she who enjoys law'),
    BabyName(name: 'Nihinsa', meaning: 'innocent'),
    BabyName(name: 'Nilukshi', meaning: 'a self-expressive woman'),
    BabyName(name: 'Nimali', meaning: 'an independent woman'),
    BabyName(name: 'Nimthaki', meaning: 'logical and sane'),
    BabyName(name: 'Nipuni', meaning: 'an intelligent woman'),
    BabyName(name: 'Nuveena', meaning: 'a special and wise leader'),
    BabyName(name: 'Onisha', meaning: 'lord of the mind'),
    BabyName(name: 'Padma', meaning: 'the lotus'),
    BabyName(name: 'Padmani', meaning: 'flower'),
    BabyName(name: 'Pahanya', meaning: 'creative; light-hearted'),
    BabyName(name: 'Pasandi', meaning: 'leader; determined'),
    BabyName(name: 'Pinidi', meaning: 'clear as hail'),
    BabyName(name: 'Poorni', meaning: 'love and happiness'),
    BabyName(name: 'Prema', meaning: 'love'),
    BabyName(name: 'Punya', meaning: 'good work; purity'),
    BabyName(name: 'Purni', meaning: 'complete'),
    BabyName(name: 'Rangani', meaning: 'she who has excellent dancing skills'),
    BabyName(name: 'Ranpalee', meaning: 'a noble leader'),
    BabyName(name: 'Ravima', meaning: 'sweet'),
    BabyName(name: 'Sachish', meaning: 'a person with good mind'),
    BabyName(name: 'Sanhitha', meaning: 'good hearted'),
    BabyName(name: 'Sarasi', meaning: 'surrendered'),
    BabyName(name: 'Selvakumari', meaning: 'the princess of money'),
    BabyName(name: 'Shanthi', meaning: 'calm; peace'),
    BabyName(name: 'Shoba', meaning: 'beauty'),
    BabyName(name: 'Sisira', meaning: 'independent'),
    BabyName(name: 'Sriyani', meaning: 'gentle; light'),
    BabyName(name: 'Suranga', meaning: 'a divine person'),
    BabyName(name: 'Susanthika', meaning: 'an acive girl'),
    BabyName(name: 'Tourmaline', meaning: 'jewel'),
    BabyName(name: 'Upeksha', meaning: 'waiting'),
    BabyName(name: 'Vidhusahani', meaning: 'an educated woman'),
    BabyName(name: 'Vino', meaning: 'sweet'),
  ];

  final List<BabyName> boyNames = [
    BabyName(name: 'Liam', meaning: 'Strong-willed warrior'),
    BabyName(name: 'Noah', meaning: 'Rest, comfort'),
    BabyName(name: 'Ethan', meaning: 'Strong, firm'),
    BabyName(name: 'William', meaning: 'Resolute protector'),
  ];

  // Filtered list for each tab
  List<BabyName> filteredGirlNames = [];
  List<BabyName> filteredBoyNames = [];

  // Letter filter
  String? filterLetter;

  @override
  void initState() {
    super.initState();
    // Initialize the filtered lists with all names
    filteredGirlNames = girlNames;
    filteredBoyNames = boyNames;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          // back button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PregnancyHomeView()));
            },
          ),
          title: const Text('Baby Names'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Girls'),
              Tab(text: 'Boys'),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            buildNamesDataTable(filteredGirlNames),
            buildNamesDataTable(filteredBoyNames),
          ],
        ),
      ),
    );
  }

  Widget buildNamesDataTable(List<BabyName> names) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Filter by Letter:'),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: filterLetter,
                onChanged: (String? newValue) {
                  setState(() {
                    filterLetter = newValue;
                    // Filter the names based on the selected letter
                    filteredGirlNames = _applyFilter(girlNames, filterLetter);
                    filteredBoyNames = _applyFilter(boyNames, filterLetter);
                  });
                },
                items: ['All', ...'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')]
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Meaning')),
              ],
              rows: names
                  .map<DataRow>(
                    (name) => DataRow(
                  cells: [
                    DataCell(Text(name.name)),
                    DataCell(Text(name.meaning)),
                  ],
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<BabyName> _applyFilter(List<BabyName> names, String? letter) {
    if (letter == null || letter == 'All') {
      return names; // Return all names when "All" is selected
    } else {
      return names.where((name) => name.name.startsWith(letter)).toList();
    }
  }
}

class BabyName {
  final String name;
  final String meaning;

  BabyName({required this.name, required this.meaning});
}
