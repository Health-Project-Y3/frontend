import 'package:flutter/material.dart';
import 'menu_view.dart';

class BabyNamesView extends StatelessWidget {
  const BabyNamesView({Key? key}) : super(key: key);

  // Sample list of sri lankan baby names

  // final List<String> _names = <String>['Ama','Amanda','Bhagya','Chathu','Dinithi','Fathima','Gayani','Hansi','harshani','Hashani','Hiruni','Janani','Kalpani','Nethmi','Nipuni','Piyumi','Rashmi','Sachini','Samadhi','Sanduni','Sarah','senuri','Shehara','Tharushi','Thilini','Upeksha','Ashan','Ravindu','Tharaka','Nuwan','Gayan','Supun','Thilina','Sanjeewa','Buddhika','Roshan','Amila','Tharindu','Chathura','Ishara','Sampath','Shehan','kasun','Sandun','Sachintha','Isuru','Sahan','Ruwan','Hasitha','Aruna','Pasindu','Lahiru'];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Baby Names'),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MenuView()));
                      })),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs : [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Boys",
                    ),
                    Tab(
                      text: "Girls",
                    )
                  ],
                )
              ),
              ),
            ),
          body: TabBarView(
            children: [
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    // white color
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Ama')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Amanda')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Bhagya')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Chathu')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Dinithi')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Fathima')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Gayani')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Hansi')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Harshani')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Hashani')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Hiruni')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Janani')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Kalpani')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Nethmi')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Nipuni')),
                  ),
                  Container(
                    height: 50,
                    // white color
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Ashan')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Ravindu')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Tharaka')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Nuwan')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Gayan')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Supun')),
                  ),

                ],
              ),
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    // white color
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Ashan')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Ravindu')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Tharaka')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Nuwan')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Gayan')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Supun')),
                  ),
                ],
              ),
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    // white color
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Ama')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Amanda')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Bhagya')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Chathu')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Dinithi')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Fathima')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Gayani')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Hansi')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Harshani')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Hashani')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Hiruni')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Janani')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Kalpani')),
                  ),
                  Container(
                    height: 50,
                    // color: Colors.amber[500],
                    child: const Center(child: Text('Nethmi')),
                  ),
                  Container(
                    height: 50,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Center(child: Text('Nipuni')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}