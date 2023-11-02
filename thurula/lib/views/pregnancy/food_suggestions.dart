import 'package:flutter/material.dart';

class FoodViewPage extends StatefulWidget {
  @override
  _FoodViewPageState createState() => _FoodViewPageState();
}

class _FoodViewPageState extends State<FoodViewPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<String> trimesters = ["First Trimester", "Second Trimester", "Third Trimester"];

  final List<List<Map<String, String?>>> foods = [
    // First Trimester
    [
      {"name": "Spinach", "description": "Spinach is high in folic acid, which is crucial in allowing your baby’s neural tube to properly fuse in the first month after conception."},
      {"name": "Lentils", "description": "Protein is important during each trimester, as it aids in the proper growth of your baby’s tissue and muscle."},
      {"name": "Lean Beef", "description": "Beef is a great source of iron, and as long as you do not eat it undercooked, beef is great for you and your unborn baby. Remember: grass-fed, organic, and hormone-free is the best choice for expecting moms!"},
      {"name": "Salmon", "description": "Salmon is high in calcium and Vitamin D, and is one of the safer fish to eat while pregnant."},
      {"name": "Collard Greens", "description": "Collard greens are high in iron, and many pregnant women lack enough iron."},
      {"name": "Chicken", "description": "Chicken is high in iron, which creates red blood cells and helps your body get enough oxygen."},
      {"name": "Yogurt", "description": "Yogurt is high in calcium and Vitamin D, and eating it ensures your body is getting enough, which prevents your baby from having to 'steal' it from your bones."},
      {"name": "Broccoli", "description": "Broccoli is surprisingly high in iron, which is needed in the first trimester to form red blood cells in your baby."},

      {"name": "Asparagus", "description": "Asparagus is high in Vitamin D, of which many women are deficient."},
      {"name": "Nuts", "description": "Pregnant women need an extra 60 grams of protein a day beginning the first trimester of pregnancy."},
      {"name": "Cottage Cheese", "description": "Cottage cheese is another good source of protein for pregnant women."},
      // Add more food items for the first trimester...
    ],

    // Second Trimester
    [
      {"name": "Glass of Milk", "description": "A glass of semi-skimmed milk is packed with calcium and magnesium. If you do not eat dairy products, you should have calcium-fortified soya foods, such as soya yoghurts. Keeping up your stores of calcium in pregnancy helps your baby's bones and teeth to develop and grow strong, and a vitamin D supplement helps your body to absorb and use calcium."},
      {"name": "Baked Potato with Beans", "description": "A jacket potato with baked beans makes a magnesium, iron, and fiber-rich meal. Magnesium is important for bone development and helps your body to convert food into energy."},
      {"name": "A Variety of Vegetables", "description": "Incorporate vegetables that contain magnesium and calcium such as broccoli, green beans, carrots, cabbage, and okra into your meals. Stir-fry or steam to retain the nutrients, and try not to overcook them."},
      {"name": "Sunflower and Pumpkin Seeds", "description": "A small handful of sunflower seeds or pumpkin seeds, whether as a snack to nibble, or added to yoghurt and salads, will give you a magnesium, iron, and omega-3 boost."},
      {"name": "Dried Fruit", "description": "Dried fruit such as apricots, dates, and figs contain calcium and iron, and are a great snack to have stashed in your desk. Or add some chopped to low-fat yoghurt."},

      {"name": "Peanut Butter on Wholemeal Bread", "description": "Peanut butter, or any nut butter, contains healthy fats and is a good source of magnesium and iron, as is fortified wholegrain bread. The two together make a sustaining snack, and a glass of milk on the side adds calcium."},
      {"name": "Cheese on Seeded Bread", "description": "Low-fat cream cheese, or any cheese that you like, on seeded bread, will give you calcium, as well as magnesium. Have it with a crunchy salad such as radishes and cucumber."},
      {"name": "Hummus", "description": "Have a pot of low-fat hummus in the fridge for a tasty way to get calcium and iron. A small wholegrain pitta or granary bread and crunchy raw vegetables will add magnesium."},
      {"name": "Canned Sardines", "description": "Mash canned sardines, including the soft, edible bones, on a slice of wholegrain toast. Or mix through spaghetti with a little parmesan and pine nuts for extra magnesium and iron. Choose sardines in oil or tomato sauce. A watercress salad is a refreshing accompaniment that is packed with calcium and vitamin C."},
      // Add more food items for the second trimester...
    ],

    // Third Trimester
    [
      {"name": "Fruits", "description": "Tuck into fresh fruit. It is bursting with vitamin C, as well as fiber. Slice fruit such as kiwis, strawberries, melon, and papaya, and take it to work for a quick snack. Or pop a piece of fruit in your bag if time is short."},
      {"name": "Ham and Tomato Salad", "description": "Choose thin slices of lean ham for a thiamine boost, and add it to a vitamin-rich salad of tomatoes, radishes, sweet corn, and lettuce. Thiamine helps to release energy from the food that you eat."},
      {"name": "Bean Chili", "description": "Use canned kidney, borlotti, cannellini, or black-eyed beans to make a spicy chili that is full of thiamine, iron, and fiber. Add fresh tomatoes and peppers for vitamin C."},
      {"name": "Lentils", "description": "Add cooked lentils to dals, soups, stews, and salads for a tasty thiamine and fiber boost. If you are buying a soup, check that it is low in salt, and make sure that you heat it through thoroughly before eating."},
      {"name": "Seeds and Nuts", "description": "If snacking on seeds and nuts is not your thing, thiamine-packed sunflower seeds and nuts such as walnuts and hazelnuts are added to some breads, breakfast cereals, and cereal bars. They also contain essential omega-3 fats."},
      {"name": "Canned Sardines", "description": "Mash canned sardines, including the soft, edible bones, on a slice of wholegrain toast. Or mix through spaghetti with a little parmesan and pine nuts for extra magnesium and iron. Choose sardines in oil or tomato sauce. A watercress salad is a refreshing accompaniment that is packed with calcium and vitamin C."},
      // Add more food items for the third trimester...
    ],
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: trimesters.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  String getImagePath(int index, int trimester) {
    int startImageIndex = 1;

    if (trimester == 1) {
      startImageIndex = 12;
    } else if (trimester == 2) {
      startImageIndex = 21; // Change this to 21 for the third trimester
    }

    final imagePath = 'assets/images/food/${startImageIndex + index}.png';
    return imagePath;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pregnancy Diet"),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Color.fromARGB(255, 220, 104, 145),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: trimesters.map((trimester) => Tab(text: trimester)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: trimesters.map((trimester) {
          final foodsForTrimester = foods[trimesters.indexOf(trimester)];
          return ListView.builder(
            itemCount: foodsForTrimester.length,
            itemBuilder: (context, index) {
              final food = foodsForTrimester[index];
              final imagePath = getImagePath(index, trimesters.indexOf(trimester));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food["name"]!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                food["description"]!,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
