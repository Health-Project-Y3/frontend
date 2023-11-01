import 'package:flutter/material.dart';
import 'package:thurula/views/menu_view.dart';

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
  // list of baby names for girls and boys
  final List<BabyName> girlNames = [
    BabyName(name: 'Achala',	meaning: '	Steady'),
    BabyName(name: 'Asheni',	meaning: '	A strict natured'),
    BabyName(name: 'Avanthi',	meaning: '	A name of historical city'),
    BabyName(name: 'Ayomi',	meaning: '	My joy'),
    BabyName(name: 'Bebi',	meaning: '	Baby'),
    BabyName(name: 'Bhakthi',	meaning: '	Devotion'),
    BabyName(name: 'Buddhika',	meaning: '	Clever and wise'),
    BabyName(name: 'Chandrika',	meaning: '	Moonlight; fair; cool'),
    BabyName(name: 'Chathura',	meaning: '	SkilLful; smart'),
    BabyName(name: 'Chatura',	meaning: '	Clever; wise'),
    BabyName(name: 'Chithkala',	meaning: '	Knowledge'),
    BabyName(name: 'Dayani',	meaning: '	Friendly'),
    BabyName(name: 'Dulani',	meaning: '	Cutting'),
    BabyName(name: 'Eromi',	meaning: '	Sun; understanding'),
    BabyName(name: 'Gayesha',	meaning: '	Expressive'),
    BabyName(name: 'Harshani',	meaning: '	Joy; delight'),
    BabyName(name: 'Hashini',	meaning: '	Happiness; joyful'),
    BabyName(name: 'Hinni',	meaning: '	God strengthens'),
    BabyName(name: 'Kusum',	meaning: '	Safe; happy'),
    BabyName(name: 'Isuri',	meaning: '	Lucky; fortunate'),
    BabyName(name: 'Lakmini',	meaning: '	Independent'),
    BabyName(name: 'Lakshani',	meaning: '	Nice with everyone'),
    BabyName(name: 'Lakshitha',	meaning: '	She who is distinguished'),
    BabyName(name: 'Liyoni',	meaning: '	The origin of writing'),
    BabyName(name: 'Lochani',	meaning: '	She who has bright eyes'),
    BabyName(name: 'Mandari',	meaning: '	The coral tree'),
    BabyName(name: 'Manisha',	meaning: '	Wish; desire'),
    BabyName(name: 'Mihika',	meaning: '	Fog; mist; snow'),
    BabyName(name: 'Minrada',	meaning: '	She who gives wisdom and love'),
    BabyName(name: 'Nadeeka',	meaning: '	Creative'),
    BabyName(name: 'Nadesha',	meaning: '	Born of a river'),
    BabyName(name: 'Nayanadini',	meaning: '	She who has attractive eyes'),
    BabyName(name: 'Neja',	meaning: '	Success in law'),
    BabyName(name: 'Nevinka',	meaning: '	She who enjoys law'),
    BabyName(name: 'Nihinsa',	meaning: '	Innocent'),
    BabyName(name: 'Nilukshi',	meaning: '	A self-expressive woman'),
    BabyName(name: 'Nimali',	meaning: '	An independent woman'),
    BabyName(name: 'Nimthaki',	meaning: '	Logical and sane'),
    BabyName(name: 'Nipuni',	meaning: '	An intelligent woman'),
    BabyName(name: 'Nuveena',	meaning: '	A special and wise leader'),
    BabyName(name: 'Onisha',	meaning: '	Lord of the mind'),
    BabyName(name: 'Padma',	meaning: '	The lotus'),
    BabyName(name: 'Padmani',	meaning: '	Flower'),
    BabyName(name: 'Pahanya',	meaning: '	Creative; light-hearted'),
    BabyName(name: 'Pasandi',	meaning: '	Leader; determined'),
    BabyName(name: 'Pinidi',	meaning: '	Clear as hail'),
    BabyName(name: 'Poorni',	meaning: '	Love and happiness'),
    BabyName(name: 'Prema',	meaning: '	Love'),
    BabyName(name: 'Punya',	meaning: '	Good work; purity'),
    BabyName(name: 'Purni',	meaning: '	Complete'),
    BabyName(name: 'Rangani',	meaning: '	She who has excellent dancing skills'),
    BabyName(name: 'Ranpalee',	meaning: '	A noble leader'),
    BabyName(name: 'Ravima',	meaning: '	Sweet'),
    BabyName(name: 'Sachish',	meaning: '	A person with good mind'),
    BabyName(name: 'Sanhitha',	meaning: '	Good hearted'),
    BabyName(name: 'Sarasi',	meaning: '	Surrendered'),
    BabyName(name: 'Selvakumari',	meaning: '	The princess of money'),
    BabyName(name: 'Shanthi',	meaning: '	Calm; peace'),
    BabyName(name: 'Shoba',	meaning: '	Beauty'),
    BabyName(name: 'Sisira',	meaning: '	Independent'),
    BabyName(name: 'Sriyani',	meaning: '	Gentle; light'),
    BabyName(name: 'Suranga',	meaning: '	A divine person'),
    BabyName(name: 'Susanthika',	meaning: '	An acive girl'),
    BabyName(name: 'Tourmaline',	meaning: '	Jewel'),
    BabyName(name: 'Upeksha',	meaning: '	Waiting'),
    BabyName(name: 'Vidhusahani',	meaning: '	An educated woman'),
    BabyName(name: 'Vino',	meaning: '	Sweet'),
  ];

  final List<BabyName> boyNames = [
    BabyName(name: 'Agara', meaning: 'House; The dwelling place'),
    BabyName(name: 'Ajantha', meaning: 'He who is creative; Name of a famous Buddhist cave'),
    BabyName(name: 'Ajith', meaning: 'Victorious; Invincible; Unconquerable; One who cannot be defeated by anyone'),
    BabyName(name: 'Amithnal', meaning: 'A loving and wise leader'),
    BabyName(name: 'Asanka', meaning: 'Fearless; One without doubt'),
    BabyName(name: 'Ashane', meaning: 'Grace; Favoured; God is gracious; God has shown favour'),
    BabyName(name: 'Asiri', meaning: 'Blessings'),
    BabyName(name: 'Athula', meaning: 'Something that\'s immeasurable; Incomparable'),
    BabyName(name: 'Bandula', meaning: 'He who is outstanding'),
    BabyName(name: 'Buddhika', meaning: 'He who is clever and wise'),
    BabyName(name: 'Chamara', meaning: 'Expressive'),
    BabyName(name: 'Chaminda', meaning: 'An experienced person'),
    BabyName(name: 'Champaka', meaning: 'A flower'),
    BabyName(name: 'Chathura', meaning: 'He who is skillful, smart, and genius'),
    BabyName(name: 'Chatura', meaning: 'Fosterer of genius'),
    BabyName(name: 'Chrishantha', meaning: 'Social; A sociable being'),
    BabyName(name: 'Diyon', meaning: 'Brave birth'),
    BabyName(name: 'Duminda', meaning: 'The Bo tree; Bodhi tree'),
    BabyName(name: 'Erajh', meaning: 'Morning light'),
    BabyName(name: 'Geethan', meaning: 'He who gains honor through songs'),
    BabyName(name: 'Inesh', meaning: 'King of the kings'),
    BabyName(name: 'Insith', meaning: 'A leader\'s heart'),
    BabyName(name: 'Iranga', meaning: 'Expressive'),
    BabyName(name: 'Jeewana', meaning: 'Life or giving life'),
    BabyName(name: 'Kalani', meaning: 'Heaven; Sky; Royal one'),
    BabyName(name: 'Kavith', meaning: 'Poet'),
    BabyName(name: 'Kevin', meaning: 'Handsome by birth; Gentle'),
    BabyName(name: 'Kosala', meaning: 'The name means Lion'),
    BabyName(name: 'Kovider', meaning: 'Wisdom'),
    BabyName(name: 'Lashith', meaning: 'A Sri Lankan name'),
    BabyName(name: 'Manil', meaning: 'Jewel of a Son; Gem of a Son; Precious; Gem'),
    BabyName(name: 'Manura', meaning: 'Good for mankind'),
    BabyName(name: 'Mewan', meaning: 'One with a good personality; Looks like a supermodel'),
    BabyName(name: 'Muralidharan', meaning: 'The bearer of the flute'),
    BabyName(name: 'Nelith', meaning: 'Personification of law'),
    BabyName(name: 'Nethaka', meaning: 'He who has the ability for legal argument'),
    BabyName(name: 'Nishantha', meaning: 'Night\'s end; Dawn'),
    BabyName(name: 'Oshan', meaning: 'A little warm'),
    BabyName(name: 'Pamu', meaning: 'Chief'),
    BabyName(name: 'Pediya', meaning: 'A strong and powerful individual'),
    BabyName(name: 'Piraichudan', meaning: 'A person who loves horses'),
    BabyName(name: 'Ranuga', meaning: 'He who journeys with gold'),
    BabyName(name: 'Sahan', meaning: 'To forgive'),
    BabyName(name: 'Sandun', meaning: 'Sandalwood'),
    BabyName(name: 'Sanhitha', meaning: 'He who is good-hearted'),
    BabyName(name: 'Sanjeeva', meaning: 'A form of Sanjeev; It means living or reviving'),
    BabyName(name: 'Sansuka', meaning: 'Good comfort'),
    BabyName(name: 'Sasrutha', meaning: 'Personification of truth'),
    BabyName(name: 'Shalinka', meaning: 'He who is modest'),
    BabyName(name: 'Shanilka', meaning: 'One who is determined and confident man'),
    BabyName(name: 'Sisira', meaning: 'He who is independent'),
    BabyName(name: 'Sriyani', meaning: 'Light; Luster; Radiance; Splendor'),
    BabyName(name: 'Suranga', meaning: 'A divine person'),
    BabyName(name: 'Suvik', meaning: 'One with a speedy health'),
    BabyName(name: 'Tavish', meaning: 'Son of Tamhas'),
    BabyName(name: 'Tharindu', meaning: 'Moon'),
    BabyName(name: 'Tharupiyum', meaning: 'A star-like lotus'),
    BabyName(name: 'Thehan', meaning: 'Threefold honors'),
    BabyName(name: 'Theshana', meaning: 'Gift of god'),
    BabyName(name: 'Thirana', meaning: 'Permanent honor'),
    BabyName(name: 'Vidu', meaning: 'Learned'),
    BabyName(name: 'Vimukhti', meaning: 'A variant of Moksha; Emancipation'),
    BabyName(name: 'Vinsanda', meaning: 'He who enjoys with his heart'),
    BabyName(name: 'Visvadinu', meaning: 'He who has won the universe'),
    BabyName(name: 'Zev', meaning: 'Wolf'),
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
                MaterialPageRoute(builder: (context) => const MenuView()),
              );
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
              const Text(
                  'Filter by Letter:',
                  style: TextStyle(
                      color: Color.fromARGB(255, 88, 119, 161),
                  ),
              ),
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
                DataColumn(label: Text('Name',
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
                ),
                DataColumn(label: Text('Meaning',
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
                ),
              ],
              rows: names
                  .map<DataRow>(
                    (name) => DataRow(
                  cells: [
                    DataCell(Text(
                        name.name,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 131, 131, 131)
                        ),)
                    ),
                    DataCell(Text(
                        name.meaning,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 131, 131, 131)
                        ),
                    )),
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
