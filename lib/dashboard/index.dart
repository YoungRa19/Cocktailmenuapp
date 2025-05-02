import 'package:flutter/material.dart';
import 'package:coktailmenuapp/models/drink.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool loading = true;
  String? drinkname;
  List<Drink> drinks = [];

  @override
  void initState() {
    super.initState();
    getDrink();
  }

  Future<void> getDrink() async {
    drinks = await Drink.getDrink();
    for (var drink in drinks) {
      print(drink.toMap());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Cocktail",
          style: TextStyle(color: Colors.orangeAccent),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: drinks.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  color: Colors.white24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drinks[index].strDrink ?? 'Cocktail no disponible',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
