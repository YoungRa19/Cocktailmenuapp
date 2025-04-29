import 'package:flutter/material.dart';
import 'package:coktailmenuapp/models/cocktail.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool loading = true;
  List<Cocktail> cocktails = [];

  @override
  void initState() {
    super.initState();
    getCocktail();
  }

  Future<void> getCocktail() async {
    cocktails = await Cocktail.getCocktail();
    for (var cocktail in cocktails) {
      print(cocktail.toMap());
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
              itemCount: cocktails.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  color: Colors.white24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cocktails[index].cocktail ?? 'Cocktail no disponible',
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
